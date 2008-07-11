class OrderRequestsController < ApplicationController
  auto_complete_for :order_product, :description
#  before_filter :authorize
  def index
  end

  def new
    @order = Order.new
    @order.date = Date.today
    @order.user_id = session[:user]
    1.times{ @order.order_products.build }
    @order.order_providers.build.provider = Provider.new
    1.times{ @order.order_providers.build }
  end

  def create
    @order = Order.new(:order_status_id => 1, :date => Date.today)
    self.set_user(@order)
    @order.add_products(params[:products])
    @order.add_providers(params[:providers])

    respond_to do |format|
      if @order.save
        format.html { render :action => "create" }
        format.xml  { render :xml => @order, :status => :created, :location => @order }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
   end
end
