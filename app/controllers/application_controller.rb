# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  before_filter :get_published_sections_for_main_menu
  after_filter :discard_flash_on_ajax
  
  # AuthLogic
  filter_parameter_logging :password, :password_confirmation
  helper_method :current_user_session, :current_user, :authorized?
  
  
  # Do not render template for AJAX calls
  layout proc{ |c| c.request.xhr? || c.request.format.js? ? false : "application" }
  
  def bad_url_redirect
    flash[:error] = 'That URL does not exist.'
    redirect_to root_url
  end
  
  private
  
  def get_published_sections_for_main_menu
    @root_sections = Section.all(:order => :position, :conditions => { :published => true, :parent_id => nil })
  end
  
  def discard_flash_on_ajax
    flash.discard if request.xhr? || request.format.js?
  end
  
  # AuthLogic
  def authorized?(role=nil)
    if current_user
      unless role.blank?
        @current_user.role == role.to_s
      else
        true
      end
    end
  end
  
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
      store_location
      flash[:notice] = "You must be logged in to access this page"
      redirect_to new_user_session_url
      return false
    end
  end

  def require_no_user
    if current_user
      store_location
      flash[:notice] = "You must be logged out to access this page"
      redirect_to account_url
      return false
    end
  end

  def store_location
    session[:return_to] = request.request_uri
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
  
end
