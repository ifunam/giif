Given /^a basic order with a set of product and a set of providers$/ do
  @order = Order.new(:order_status_id => 1, :date => Date.today, :user_id => 2)
  @order.products_attributes = [
                                { :quantity => 2, :description => 'Hub Koesre KIL-09',:product_category_id => 1 },
                                { :quantity => 10, :description => 'Macbook Air', :product_category_id => 2 }
                                ]
  @order.providers_attributes = [ { :name => 'Apple Store', :email => 'sales@apple.com' }, { :name => 'Dell MX', :email => 'sales@dell.com.mx'} ]            
end

When /^I save the order this will use the default status$/ do
  @order.valid? == true
  @order.save
end

Then /^the order status should be "Sin Enviar"$/ do
  @order.current_status == "Sin Enviar"
end

When /^I sent the order to our providers$/ do
  @order.send_estimate_request
end

Then /^the order status should be "Cotizaciones en progreso"$/ do
  @order.current_status == "Cotizaciones en progreso"
end
