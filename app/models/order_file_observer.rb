class OrderFileObserver < ActiveRecord::Observer
  observe :order_file

  def after_create(order_file)
      Notifier.deliver_estimate_response_from_provider(order_file.order, order_file.provider) if order_file.order.order_status_id == 2
  end
end
