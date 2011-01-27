class UsersController < ApplicationController
  before_filter :require_user, :except => ['login_dev', 'login', 'callback']


  # Log user in without going through twitter
  def login_dev
    @user = User.first(:conditions => {:twitter_name => params[:twitter_name]})
    if !@user
      @user = User.new(:twitter_name => params[:twitter_name],
                       :name => params[:name],
                       :token => '123',
                       :secret => '123')
      @user.save!
    end

    session[:user_id] = @user.id
    
    # Redirect to the talks page
    redirect_to(talks_url)
  end


  # Send user to twitter.com for authorization
  def login
    @request_token = @client.request_token(:oauth_callback => user_callback_url)
    session[:request_token] = @request_token.token
    session[:request_token_secret] = @request_token.secret

    redirect_to @request_token.authorize_url #.gsub('authorize', 'authenticate') 
  end


  # Callback called by twitter.com after OAuth authentication
  def callback
    begin
      # Exchange the request token for an access token.
      @access_token = @client.authorize(session[:request_token],
                                        session[:request_token_secret],
                                        :oauth_verifier => params[:oauth_verifier])
      
      if @client.authorized?
        # Get the user's screen name
        user_info = @client.info rescue JSON::ParserError
        
        unless user_info['screen_name']
          flash[:notice] = "Authentication failed: We couldn't fetch your screen name from Twitter. Oh no!"
          redirect_to(talks_url) and return
        end

        # We have an authorized user, save the information to the database.
        @user = User.first(:conditions => ["twitter_name = ?", user_info['screen_name']])
        if @user
          @user.name = user_info['name']
          @user.token = @access_token.token
          @user.secret = @access_token.secret
          @user.save!
        else
          @user = User.new({ :twitter_name => user_info['screen_name'],
                             :name => user_info['name'],
                             :token => @access_token.token,
                             :secret => @access_token.secret })
          @user.save!
        end

        # Store user in session
        session[:user_id] = @user.id

        # Redirect to the talks page
        redirect_to(talks_url)
      else
        flash[:notice] = "Authentication failed: We couldn't verify your credentials. Try again? "
        redirect_to(talks_url)
      end

    rescue JSON::ParserError => e
      logger.warn "Error parsing response from Twitter when authenticating: "+e
      flash[:notice] = "Authentication failed: We couldn't verify your credentials. Try again? "
      redirect_to(talks_url)
    end
  end


  # Log out
  def logout
    session[:user_id] = nil
    flash[:notice] = "You have successfully logged out. Goodbye!"
    redirect_to(talks_url)
  end
end
