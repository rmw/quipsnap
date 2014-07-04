require 'rails_helper'

RSpec.describe LoggingController, :type => :controller do

  describe "GET /auth" do

    it "redirects to the home page" do
      get :auth
      expect(response).to redirect_to home_path
    end

    ### Needs a way to pass request_token.get_access_token 
    ### without raising an exception
    # it "assigns a user using the authentication tokens" do
    #   request_token = double()
    #   allow(request_token).to receive(:get_access_token) { '123' }
    #   get :auth
    #   expect(assigns(:user)).to be_instance_of(User)
    # end

  end

end
