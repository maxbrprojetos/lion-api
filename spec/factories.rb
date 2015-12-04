FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Test#{n}" }
    sequence(:nickname) { |n| "test#{n}" }
    sequence(:avatar_url) { |n| "http://lol.com/omg#{n}.png" }
    sequence(:email) { |n| "test#{n}@test.com" }
    sequence(:api_token) { |n| "123456789#{n}" }
    sequence(:github_id) { |n| n }
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

  factory :task do
    title 'test'
    user
  end

  factory :comment do
    body 'This is a comment'
    user
    task
  end

  factory :pull_request do
    base_repo_full_name 'dummyorg/dummyrepo'
    sequence(:number) { |n| n }

    data do
      {
        'merged' => true,
        'merged_at' => '2011-01-26T19 =>01 =>12Z',
        'user' => { 'login' => 'current_user' },
        'base' => {
          'repo' => { 'full_name' => 'dummyorg/dummyrepo' }
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
    sequence(:start_date) { |n| n.week.ago }
    points { rand(1..100) }
  end
end
