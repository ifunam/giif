# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
    def logged_user
#    session[:user].nil? ? '<login>' : User.find(session[:user]).login
      User.find(session[:user]).login.capitalize
  end
end
