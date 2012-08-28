require 'digest/sha1'
FactoryGirl.define do
  factory(:user) do
    sequence :email do |n|
      "email#{n}@example.com"
    end
    password 'my_password'
    password_confirmation 'my_password'
    company_name 'Test company'
  end
end
