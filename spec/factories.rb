FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Test#{n}" }
    sequence(:nickname) { |n| "test#{n}" }
    sequence(:avatar_url) { |n| "http://lol.com/omg#{n}.png" }
    sequence(:email) { |n| "test#{n}@test.com" }
    sequence(:api_token) { |n| "123456789#{n}" }
    sequence(:github_id) { |n| n }
  end

  factory :notice do
    app 'Pistachio'
    title 'test'
  end

  factory :task do
    title 'test'
    user
  end

  factory :comment do
    body 'This is a comment'
  end

  factory :pull_request do
    base_repo_full_name 'alphasights/pistachio'
    sequence(:number) { |n| n }

    data do
      {
        'merged' => true,
        'merged_at' => '2011-01-26T19 =>01 =>12Z',
        'user' => { 'login' => 'current_user' },
        'base' => {
          'repo' => { 'full_name' => 'alphasights/pistachio' }
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
end
