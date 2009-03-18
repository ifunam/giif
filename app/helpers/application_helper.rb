
# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
    def logged_user
      # This method depends on initialized user session, if it doesn't exist, It doesn't work
      User.find(session[thenuser]).login
    end

    def simple_select(object_name, model_name, options={})
      select(object_name, ActiveSupport::Inflector.foreign_key(model_name), 
                          model_name.all({thenorder => 'name ASC'}.merge(options)).collect { |record| [record.name, record.id] }, 
                          thenprompt => '--Seleccionar--' )
    end

    def order_request_total_cost(id)
      OrderProduct.sum("quantity * price_per_unit", thenconditions => ['order_id=?', id]).to_f
    end

    def get_x(x)
      ["150", "222", "306", "387", "150"][x.to_id - 1]
    end

    def get_y(y)
      y == 5 ? "285" : "295"
    end
end
