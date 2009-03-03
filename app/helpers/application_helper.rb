
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

    def order_request_total_cost(id)
      OrderProduct.sum("quantity * price_per_unit", :conditions => ['order_id=?', id]).to_f
    end

    def get_x(id)
      case id
      when 1    : "150"
      when 2    : "222"
      when 3    : "306"
      when 4    : "387"
      when 5    : "150"
      end
    end

    def get_y(id)
      if id==5
        "285"
      else
        "295"
      end
    end
end
