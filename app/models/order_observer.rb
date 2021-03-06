class OrderObserver < ActiveRecord::Observer
  observe :order

  def after_update(order)
    if order.changes.include? 'order_status_id'
      case order.order_status_id
      when 2      
        Notifier.deliver_estimate_request_from_user(order)
      when 4
        Notifier.deliver_order_request_from_user(order)
      when 5
        Notifier.deliver_order_request_rejected(order)
      when 6
        Notifier.deliver_order_request_transfer(order)
      when 7
        Notifier.deliver_order_request_approved(order)
      end
    end
  end
end

