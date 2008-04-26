
class OrderRequestsController < ApplicationController
  def index
  end

  def new
    @order = Order.new
    @order.date = Date.today
    @order.user_id = session[:user]
    @order.administrative_key = 10
    1.times{ @order.order_products.build }
  end

  def add_product
    @product =  OrderProduct.new(params[:order_products])
    @order.order_products << @product
  end
end
