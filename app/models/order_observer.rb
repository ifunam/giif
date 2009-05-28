class OrderObserver < ActiveRecord::Observer
  observe :order

  def after_update(order)
    case order.order_status_id
      when 2
        if order.files.nil?
          Notifier.deliver_estimate_request_from_user(order)
        else
          Notifier.deliver_estimate_response_from_provider(order)  
        end
      when 3
        Notifier.deliver_request_approved(order)
      when 4
        Notifier.deliver_request_approved(order)
      end
  end
end

