require 'digest/sha1'
FactoryGirl.define do
  factory(:user) do
    sequence :email do |n|
      "email#{n}@example.com"
    end
    plain_password 'my_password'
  end

  factory(:user_with_company, :parent => :user) do
    after(:build) { |user|
      user.company = create(:company, user: user)
    }
  end
end
