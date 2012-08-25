FactoryGirl.define do
  factory(:user) do
    sequence :email do |n|
      "email#{n}@example.com"
    end
  end

  factory(:user_with_company, :parent => :user) do
    after(:build) { |user|
      user.company = create(:company, user: user)
    }
  end
end
