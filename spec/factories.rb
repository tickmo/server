FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person-#{n}@example.com" }
    password 'password'
    password_confirmation 'password'

    factory :admin do
      admin true
    end
  end
end
