namespace :data_fill do
  desc "a task to populate old style reviews with actual approvals"
  task review_state: :environment do
    unapproved_reviews = PullRequestReview.where(state: nil)
    puts "Found #{ActionController::Base.helpers.pluralize(unapproved_reviews.count, 'unapproved review')}"
    puts "Backfilling..."
    unapproved_reviews.update_all(state: PullRequestReview::APPROVAL_STATE)
    puts "Done"
    puts "Found #{ActionController::Base.helpers.pluralize(unapproved_reviews.count, 'unapproved review')}"
  end

  desc "a task to make review scores long lived"
  task new_review_scores: :environment do
    reviews = PullRequestReview.missing_scores.includes(:pull_request, :user)
    puts "Found #{ActionController::Base.helpers.pluralize(reviews.count, 'scoreless pull request review')}"
    puts "Backfilling pull request review scores..."
    reviews.each do |review|
      review_points = (review.pull_request.points / 2).round
      Score.create!(
        created_at: review.pull_request.merged_at,
        user: review.user,
        points: review_points,
        pull_request_review: review
      )
    end
    puts "Done"
    puts "Found #{ActionController::Base.helpers.pluralize(reviews.count, 'scoreless pull request review')}"
  end

  desc "a task to make pr scores long lived"
  task new_pr_scores: :environment do
    prs = PullRequest.missing_scores.includes(pairings: :user)
    puts "Found #{ActionController::Base.helpers.pluralize(prs.count, 'scoreless pull request')}"
    puts "Backfilling pull request scores..."
    prs.each do |pr|
      pairers = pr.pairings.map(&:user)
      pair_points = (pr.points / pairers.count).round
      pairers.each do |user|
        Score.create!(
          created_at: pr.merged_at,
          user: user,
          points: pair_points,
          pull_request: pr
        )
      end
    end
    puts "Done"
    puts "Found #{ActionController::Base.helpers.pluralize(prs.count, 'scoreless pull request')}"
  end

end
