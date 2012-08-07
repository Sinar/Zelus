FactoryGirl.define do

  factory :person do |t|
    initialize_with { Person.create }
    sequence(:name) { |n| "Nicole Neal (#{n})" }
  end

  factory :user do
    initialize_with { User.create }
    sequence(:name) { |n| "user-#{n}" }
    after(:build) do |u|
      u.generate_api_key
    end
  end

end
