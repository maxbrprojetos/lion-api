FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    nickname { Faker::Internet.user_name(nil, %w(-)) }
    avatar_url { Faker::Internet.url }
    email { Faker::Internet.email }
    api_token { Faker::Internet.password }
    github_id { Faker::Internet.device_token }
  end

  factory :access_token do
    association :user

    trait :active do
      expires_at { Time.zone.now + 1.week }
    end

    trait :inactive do
      expires_at { Time.zone.now - 1.week }
    end
  end

  factory :pull_request do
    base_repo_full_name { "#{Faker::Internet.user_name}/#{Faker::Lorem.word}" }
    body { Faker::Lorem.sentence }
    number { Faker::Number.number(3).to_i }
    merged_at { "#{Time.new(2016, 1, 2)}" }
    number_of_comments { Faker::Number.number(2).to_i }
    number_of_commits { Faker::Number.number(2).to_i }
    number_of_additions { Faker::Number.number(2).to_i }
    number_of_deletions { Faker::Number.number(2).to_i }
    number_of_changed_files { Faker::Number.number(2).to_i }

    user
  end

  factory :score do
    association :user
    association :pull_request

    trait :previous_week do
      created_at { Time.zone.now - 1.week }
    end
  end

  factory :score_for_review, class: Score do
    association :user
    association :pull_request_review
  end

  factory :pull_request_review do
    association :user
    association :pull_request
    state 'APPROVED'
  end

  factory :weekly_winning do
    association :winner, factory: :user
    start_date 1.week.ago
    points { Faker::Number.number(3).to_i }
  end
end
