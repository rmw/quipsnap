require 'rails_helper'

RSpec.describe LoggingController, :type => :controller do

  describe "GET /auth" do

    it "assigns a user using the authentication tokens" do
      get :auth
      expect(assigns(:user)).to be_instance_of(User)
    end

    it "redirects to the home page" do
      get :auth
      expect(response).to redirect_to root_path
    end

  end

end
