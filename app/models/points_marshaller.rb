class PointsMarshaller
  PAIRING_REGEX = /paired[\s]*with[\s]*(?<names>[@\w+\s]+)/i

  def initialize(data:)
    @data = data
  end

  attr_accessor :data

  def marshall
    pull_request = PullRequest.create(data)
    if pull_request.present? && pull_request.persisted?
      create_pairings(pull_request)
      create_reviews(pull_request)
    end

    pull_request
  end

  private

  def create_reviews(pr)
    review_points = (pr.points / 2).round
    pr.comments.each do |comment|
      reviewer = User.where(nickname: comment.user.login).first
      pull_request_review = PullRequestReview.create(
        user: reviewer,
        body: comment.body,
        pull_request: pr
      )
      if pull_request_review.present? && pull_request_review.persisted?
        Score.give(time: pr.merged_at, user: reviewer, points: review_points)
      end
    end
  end

  def create_pairings(pr)
    pair_points = (pr.points / pairers.size).round
    pairers.each do |u|
      pairing = Pairing.create(user: u, pull_request: pr)
      if pairing.present? && pairing.persisted?
        Score.give(time: pr.merged_at, user: u, points: pair_points)
      end
    end
  end

  def pairers
    @pairers ||= if match_pairers.present?
      User.where(nickname: sanitize_pairs.push(data[:user].nickname))
    else
      [data[:user]]
    end
  end

  def sanitize_pairs
    match_pairers[:names].split(' ').select{ |p| p.include?('@') }.map do |p|
      p.delete('@')
    end
  end

  def match_pairers
    @match_pairers ||= data[:body].match(PAIRING_REGEX)
  end
end
