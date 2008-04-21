# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  before_filter :login_required
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '6daee55e83b237ac80abfbade22cd326'

  private
  def login_required
     store_location
     (!session[:user].nil? and !User.find(session[:user]).nil?) ? (return true) : (redirect_to :controller=> :sessions and return false)
  end

  def store_location
    session[:return_to] = request.request_uri
  end

  def authorization_required
   session[:user] == 1 ? (return true)  : (render :text => 'You are not the admin, we are recording this request!' and return false)
  end
end
