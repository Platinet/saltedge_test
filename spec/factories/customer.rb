FactoryBot.define do
  factory :customer do
    association :user
  end
end