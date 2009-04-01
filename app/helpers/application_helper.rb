
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

    def numerate_list(items, field_name)
      items.collect {|p| content_tag(:ol, content_tag(:li, p[field_name]))}
    end

    def product_list(products)
      products.collect {|p| content_tag(:ol, content_tag(:li, p.description))}
    end

    def provider_list(providers)
      providers.collect {|p| content_tag(:ol, content_tag(:li, p.name))}
    end

end
