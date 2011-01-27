require 'twitter_oauth'

# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details


  before_filter :load_user
  around_filter :handle_talk_not_found

  def load_user
    begin
      token = secret = ''

      # Load user
      if session[:user_id]
        @user = User.find(session[:user_id])
        token = @user.token
        secret = @user.secret
      end
    rescue ActiveRecord::RecordNotFound
      session[:user_id] = nil
    end

    # Initialise Twitter client
    @client = TwitterOAuth::Client.new(:consumer_key => TwitterOAuth::CONSUMER_KEY,
                                       :consumer_secret => TwitterOAuth::CONSUMER_SECRET,
                                       :token => token,
                                       :secret => secret)
  end


  def require_user
    if not @user
      session[:return_to] = request.request_uri
      flash[:notice] = "Please log in to view this page."
      redirect_to talks_path
    end
  end

  def require_development_environment
    if Rails.env != 'development'
      flash[:notice] = "This page is not currently available."
      redirect_to talks_path
    end
  end

  def handle_talk_not_found
    begin
      yield
    rescue ActiveRecord::RecordNotFound
      redirect_to talk_not_found_path
    end
  end



  # Return whether this controller requires authorization
  # When overriding this method, you can secure only a limited set of methods like this:
  #   not ["insecureMethod", "anotherInsecureMethod"].include?(action_name)
  def secure?
    # All controllers are secure (require login) by default
    true
  end



end
