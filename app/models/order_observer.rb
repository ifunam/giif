class OrderObserver < ActiveRecord::Observer
  observe :order

  def after_update(order)
    case order.order_status_id
      when 2      
#        Notifier.deliver_estimate_request_from_user(order)
#en caso de que el proveedor suba archivos
#        Notifier.deliver_estimate_response_from_provider(order, Provider.find(1))
      when 4
        Notifier.deliver_order_request_from_user(order)
      end
  end
end

