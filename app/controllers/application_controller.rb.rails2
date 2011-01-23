require 'twitter_oauth'

# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password


  before_filter :authorize
  around_filter :handle_talk_not_found

  def authorize
    begin
      token = ''
      secret = ''

      # Load user
      if session[:user_id]
        @user = User.find(session[:user_id])
        token = @user.token
        secret = @user.secret
      end

      # Check authorization
      if secure? and not @user
        session[:return_to] = request.request_uri
        flash[:notice] = "Please log in to view this page."
        redirect_to :controller => 'talks', :action => 'index'
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
