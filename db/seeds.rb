def time_rand(from: 0.0, to: Time.now)
  Time.at(from + rand * (to.to_f - from.to_f))
end

def make_prs(number: 20, start_period: 1.week, end_period: 1.week, users: [])
  prs = []
  number.times do
    owner = users.sample || make_users(1)
    time_range = if end_period.present?
      time_rand(from: Time.now.ago(start_period), to: Time.now.ago(end_period))
    else
      time_rand(from: Time.now.ago(start_period))
    end
    pr = PullRequest.create!({
      user: owner,
      base_repo_full_name: "#{Faker::Internet.user_name}/#{Faker::Lorem.word}",
      body: Faker::Lorem.paragraph,
      number: Faker::Number.number(3).to_i,
      number_of_comments: Faker::Number.number(2).to_i,
      number_of_commits: Faker::Number.number(2).to_i,
      number_of_additions: Faker::Number.number(3).to_i,
      number_of_deletions: Faker::Number.number(3).to_i,
      number_of_changed_files: Faker::Number.number(2).to_i,
      merged_at: time_range,
      title: Faker::Lorem.sentence
    })
    prs << pr
    Pairing.create!(user: owner, pull_request: pr)
    Score.create!(created_at: pr.merged_at, user: owner, points: pr.points, pull_request: pr)

    reviewers = users.reject{ |u| u.id == owner.id }
    reviewer = reviewers.sample || make_users(1)
    review = PullRequestReview.create!(user: reviewer, body: Faker::Lorem.sentence, state: "APPROVED", pull_request: pr)
    Score.create!(created_at: pr.merged_at, user: reviewer, points: (pr.points / 2), pull_request_review: review)
  end
  prs
end

def make_users(number: 20)
  users = []
  number.times do
    name = Faker::Name.name
    nickname = Faker::Internet.user_name(name, %w(-))
    avatar_url = Faker::Avatar.image
    email = Faker::Internet.safe_email(name)
    api_token = Faker::Internet.password
    github_id = Faker::Internet.device_token

    users << User.create!(
      name: name, nickname: nickname, avatar_url: avatar_url, email: email,
      api_token: api_token, github_id: github_id
    )
  end
  users
end

def make_legends(prs: [])
  pr_ids = prs.map(&:id)
  reviews = PullRequestReview.where(pull_request_id: pr_ids)
  review_ids = reviews.map(&:id)
  scores = Score.where(pull_request_id: pr_ids).or(Score.where(pull_request_review_id: review_ids)).order(created_at: :asc)

  scores.group_by do |score|
    score.created_at.beginning_of_week
  end.map do |date, scores|
    user_id, total_points = scores.group_by(&:user_id).map do |user_id, user_scores|
      [user_id, user_scores.sum(&:points)]
    end.max_by(&:last)
    [date, user_id, total_points]
  end.each do |week, user_id, points|
    WeeklyWinning.create!(winner_id: user_id, points: points, start_date: week)
  end
end

users = make_users(number: 30)
old_prs = make_prs(number: 500, start_period: 1.year, end_period: 1.week, users: users)
new_prs = make_prs(number: 25, start_period: 1.week, end_period: nil, users: users)
make_legends(prs: old_prs)
