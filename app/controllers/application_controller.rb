class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  include UrlHelper
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  helper_method :current_user_session, :current_user
  before_filter :load_conference
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
      redirect_to home_path
    end
  end

  def require_no_user
    if current_user
      session[:return_to] = request.fullpath
      flash[:notice] = "You must be logged out to access this page."
      redirect_to home_path
    end
  end

  def require_development_environment
    if Rails.env != 'development'
      flash[:notice] = "This page is not currently available."
      redirect_to home_path
    end
  end

  def handle_talk_not_found
    begin
      yield
    rescue ActiveRecord::RecordNotFound
      redirect_to talk_not_found_path
    end
  end

  def load_conference
    if Subdomain.matches? request
      @conference = Conference.where(:subdomain => Subdomain.get(request)).first
      redirect_to home_url(:subdomain => false), :notice => "I couldn't find that conference. Sorry!" if @conference.nil?
    end
  end

  def redirect_back_or_default(default, anchor=nil)
    session[:return_to] += "##{anchor}" if anchor and !(session[:return_to] =~ /#/)
    redirect_to(session[:return_to] || default || home_url)
    session[:return_to] = nil
  end
end
