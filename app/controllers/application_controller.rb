class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :logged_in?
  helper_method :oauth_consumer
  helper_method :goodreads_client  

  def current_user
    @user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !(current_user.nil?)
  end

  def oauth_consumer
    @consumer ||= OAuth::Consumer.new(ENV['GR_KEY'], ENV['GR_SECRET'], :site => 'http://www.goodreads.com')
  end

  # need to fill this in. represents a logged in user, so we can make API calls on their behalf
  def goodreads_client
  end

end