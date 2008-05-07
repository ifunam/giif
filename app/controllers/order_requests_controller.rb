
class OrderRequestsController < ApplicationController
  def index
  end

  def new
    @order = Order.new
    @order.date = Date.today
    @order.user_id = session[:user]
    1.times{ @order.order_products.build }
  end

  def create
    @order = Order.new
    @order.order_status_id = 1
    @order.user_incharge_id = User.find(session[:user]).user_incharge.id unless User.find(session[:user]).user_incharge.nil?
    @order.date = Date.today
    self.set_user(@order)

    params[:products].each do |p|
      @product = OrderProduct.new(p)
      self.set_user(@product)
      @order.order_products <<  @product
    end

    respond_to do |format|
      if @order.save
        format.html { render :action => "create" }
        format.xml  { render :xml => @order, :status => :created, :location => @order }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @record.errors, :status => :unprocessable_entity }
      end
    end
   end

  def add_product
    @product =  OrderProduct.new(params[:order_products])
    @order.order_products << @product
  end
end
