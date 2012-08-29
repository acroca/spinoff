require 'spec_helper'

describe GameController do

  describe "GET 'show'" do
    it "returns http success" do
      user = create(:user)
      sign_in user
      get 'show'
      response.should be_success
    end
  end

end
