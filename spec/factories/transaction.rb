FactoryBot.define do
  factory :transaction do
    association :account
  end
end