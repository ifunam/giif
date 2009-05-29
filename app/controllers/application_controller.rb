# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  before_filter :login_required
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '6daee55e83b237ac80abfbade22cd326'

  protected
  def set_user(model)
    model.user_id = session[:user] if model.has_attribute? 'user_id'
    model.moduser_id = session[:user] if model.has_attribute? 'moduser_id'
    model.user_incharge_id = User.find(session[:user]).user_incharge.id if model.has_attribute? 'user_incharge_id' and !User.find(session[:user]).user_incharge.nil?
  end

  private
  def login_required
     store_location
     (!session[:user].nil? and !User.find(session[:user]).nil?) ? (return true) : (redirect_to :controller=> :sessions and return false)
  end

  def store_location
    session[:return_to] = request.request_uri
  end
  
  def user_profile
    UserProfileClient.find_by_login(User.find(session[:user]).login)
#    UserDataClient.find_by_login(User.find(session[:user]).login)
  end
  
end
