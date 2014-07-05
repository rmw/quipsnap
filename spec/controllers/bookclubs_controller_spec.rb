require 'rails_helper'

RSpec.describe BookclubsController, :type => :controller do

  describe 'GET #index' do 
    context "when visiting as a user" do
      before :each do
        user = create(:user)
        session[:user_id] = user.id
      end

      it "assigns all bookclubs to @bookclubs" do 
        bookclubs = Bookclub.all 
        get :index
        expect(assigns(:bookclubs)).to eq bookclubs
      end

      it "expects response to be successful" do
        get :index
        expect(response).to be_success
      end

      it "renders the :index template" do 
        get :index
        expect(response).to render_template("bookclubs/index")
      end

      it "assigns a new bookclub to @bookclub for the form" do
        get :index
        expect(assigns(:bookclub)).to be_a Bookclub
      end
    end

    context "when visiting as a guest user" do
      it "redirects to home path" do
        get :index
        expect(response).to redirect_to home_path
      end
    end
  end

  describe "POST #create" do

    context "valid bookclub parameters" do
      it "creates a new bookclub" do
        expect{ post :create, bookclub: attributes_for(:bookclub) }.to change(Bookclub, :count).by(1)
      end

      it "assigns false to @errors" do
        post :create, bookclub: attributes_for(:bookclub) 
        expect(assigns(:errors)).to_not be true 
      end
    end

    context "invalid bookclub parameters" do
      it "assigns true to @errors" do
        post :create, bookclub: {name: nil}
        expect(assigns(:errors)).to_not be true 
      end

      it "does not create a new bookclub in the database" do
        expect{ post :create, bookclub: {name: nil} }.to change(Bookclub, :count).by(0)
      end
    end

  end


end
