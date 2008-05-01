
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

<<<<<<< HEAD:app/controllers/order_requests_controller.rb
  def create
    @order = Order.new
    @order.order_status_id = 1
    @order.user_incharge = User.find(session[:user]).user_incharge.id unless User.find(session[:user]).user_incharge.nil?
    @order.date = Date.today
    self.set_user(@order)

    params[:products].each do |p|
      @product = OrderProduct.new(p)
      self.set_user(@product)
      @order.order_products <<  @product
    end

    respond_to do |format|
      if @order.save
        #flash[:notice] = 'Su orden de compra ha sido almacenada'
        format.html { render :action => "create" }
        format.xml  { render :xml => @order, :status => :created, :location => @order }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @record.errors, :status => :unprocessable_entity }
      end
    end
   end

=======
  def add_product
    @product =  OrderProduct.new(params[:order_products])
    @order.order_products << @product
  end
>>>>>>> 086d1987cc6c9bac21df19977a2f4c5ce6117203:app/controllers/order_requests_controller.rb
end
