# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :slot do
    association :program, factory: :movie
    day  1
    time 1

    after(:build) do |slot|
      unless slot.company
        user = create(:user)
        slot.company = user.company
      end
    end
  end
end
