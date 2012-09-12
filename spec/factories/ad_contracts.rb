# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ad_contract do
    advertiser "MyString"
    price 1
  end
end
