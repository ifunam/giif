class OrderObserver < ActiveRecord::Observer
  observe :order

  def after_update(order)
    case order.order_status_id
      when 2
        Notifier.deliver_estimate_request_from_user(order)
      when 4
        Notifier.deliver_order_request_from_user(order)
      end
  end
end

