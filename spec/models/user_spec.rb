require 'spec_helper'

describe User do
  it{ should     allow_value('user_1@example.com').for(:email)}
  it{ should_not allow_value('user_1').for(:email)}
  it{ should_not allow_value('').for(:email)}
  it{ should_not allow_value(nil).for(:email)}

  it{ should     allow_value('password').for(:plain_password)}

  it "checks uniqueness of e-mail" do
    user = User.new(email: subject.email)
    user.should_not be_valid
  end

  it 'encrypts the password' do
    user = create(:user, plain_password: 'password')
    user.reload.password.should_not == 'password'
  end

  describe ".login" do
    let(:email) { "example@example.com" }
    let(:password) { "password" }

    let!(:user) { create(:user, email: email, plain_password: password) }

    it "returns the user if the data is right" do
      User.login(email, password).should == user
    end

    it "returns nil if the password is wrong" do
      User.login(email, 'oops').should_not be_present
    end

    it "returns creates the user if the email doesn't exist" do
      last_id = User.maximum(:id)
      User.login("oops@example.com", password).id.should == last_id + 1
    end
  end
end
