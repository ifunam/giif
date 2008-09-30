
# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
    def logged_user
#    session[:user].nil? ? '<login>' : User.find(session[:user]).login
      User.find(session[:user]).login.capitalize
  end

    def simple_select(object_name, model_name, id=nil)
      field_name = Inflector.foreign_key(model_name)
      select(object_name, field_name, model_name.find(:all).collect { |record| [record.name, record.id] }, :prompt => '--Seleccionar--', :selected => id)
    end
end



