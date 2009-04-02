
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

  def numerate_list(records, *attributes)
    content_tag(:ol, records.collect { |p| content_tag(:li, attributes.collect { |a| p.send(a) }.compact.join(', ') )})
  end

  def list_products(products)
    content_tag(:ol, products.collect { |p| content_tag(:li, p.description+" --"+p.quantity.to_s+" "+p.unit_type.name+"--")})
  end

  def list_providers(providers)
    content_tag(:ol, providers.collect { |p| content_tag(:li, p.name+"  ("+p.email+")")})
  end

  def link_to_action(title, icon, action)
    link_to(image_tag(icon, :title => title), action) + link_to(title, action)
  end
end
