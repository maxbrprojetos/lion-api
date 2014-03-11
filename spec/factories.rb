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
end
