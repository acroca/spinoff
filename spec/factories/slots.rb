# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :slot do
    association :company, factory: :company
    association :program, factory: :movie
    day  1
    time 1
  end
end
