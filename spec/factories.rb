FactoryGirl.define do
  factory :user do
    name Faker::Name.name
    nickname Faker::Internet.user_name
    avatar_url Faker::Internet.url
    email Faker::Internet.email
    api_token Faker::Internet.password
    github_id Faker::Internet.device_token
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
    number Faker::Number.number(3)

    data do
      {
        'merged' => true,
        'merged_at' => '2011-01-26T19 =>01 =>12Z',
        'user' => { 'login' => user.nickname },
        'base' => {
          'repo' => { 'full_name' => base_repo_full_name }
        },
        'comments' => 10,
        'commits' => 3,
        'additions' => 100,
        'deletions' => 3,
        'changed_files' => 5
      }
    end

    user
  end

  factory :weekly_winning do
    association :winner, factory: :user
    start_date 1.week.ago
    points Faker::Number.number(3).to_i
  end
end
