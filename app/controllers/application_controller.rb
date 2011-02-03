class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  helper_method :current_user_session, :current_user
  around_filter :handle_talk_not_found


  private

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end
  
  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end

  def require_user
    unless current_user
      session[:return_to] = request.fullpath
      flash[:notice] = "Please log in to view this page."
      redirect_to talks_path
    end
  end

  def require_no_user
    if current_user
      session[:return_to] = request.fullpath
      flash[:notice] = "You must be logged out to access this page."
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

  def redirect_back_or_default(default, anchor=nil)
    session[:return_to] += "##{anchor}" if anchor and !(session[:return_to] =~ /#/)
    redirect_to(session[:return_to] || default || root_url)
    session[:return_to] = nil
  end
end
