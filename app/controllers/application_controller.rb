require 'twitter_oauth'

# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password


  before_filter :init_twitter_oauth

  def init_twitter_oauth
    token = ''
    secret = ''

    if session[:user]
      @user = session[:user]
      token = @user.token
      secret = @user.secret
    end

    @client = TwitterOAuth::Client.new(:consumer_key => TwitterOAuth::CONSUMER_KEY,
                                       :consumer_secret => TwitterOAuth::CONSUMER_SECRET,
                                       :token => token,
                                       :secret => secret)
  end
end
