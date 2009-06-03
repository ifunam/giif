class OrderObserver < ActiveRecord::Observer
  observe :order

  def after_update(order)
    case order.order_status_id
      when 2
        Notifier.deliver_estimate_request_from_user(order)
      when 3
#        Notifier.deliver_request_approved(order)
      when 4
        Notifier.deliver_request_approved(order)
      end
  end
end

