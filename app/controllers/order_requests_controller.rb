class OrderRequestsController < ApplicationController
  def index
  end

  def new
    @order = Order.new
    1.times{ @order.order_products.build }
  end
end
