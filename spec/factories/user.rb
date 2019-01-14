FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test#{n}@gmail.com" }
    password { '123123123' }
    password_confirmation { '123123123' }
    sequence(:name) { |n| "kien#{n}" }
  end
end
