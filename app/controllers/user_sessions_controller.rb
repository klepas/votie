class UserSessionsController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy
  
  def new
    @user_session = UserSession.new
    @user = User.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = "Login successful!"
      redirect_back_or_default home_url
    else
      @user = User.new
      render :action => :new
    end
  end

  def destroy
    current_user_session.destroy

    if @conference
      # If the user logged in on the root domain and they're now on a subdomain,
      # they'll need to be logged out from the root domain for the cookie to be
      # cleared.
      redirect_to user_logout_url(:subdomain => false) and return
    end

    flash[:notice] = "Logout successful!"
    redirect_back_or_default home_url
  end
end
