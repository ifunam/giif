
# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
    def logged_user
      # This method depends on initialized user session, if it doesn't exist, It doesn't work
      User.find(session[:user]).login
    end

    def simple_select(object_name, model_name, options={})
      select(object_name, ActiveSupport::Inflector.foreign_key(model_name), 
                          model_name.all({:order => 'name ASC'}.merge(options)).collect { |record| [record.name, record.id] }, 
                          :prompt => '--Seleccionar--' )
    end
end



