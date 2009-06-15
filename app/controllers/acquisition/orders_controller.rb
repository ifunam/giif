class Acquisition::OrdersController < ApplicationController

  layout "orders"

  def index
    @user_profile = user_profile
    @collection = Order.paginate_orders_for_acquisition_backend(session[:user], page=1, per_page=20)

    respond_to do |format|
      format.html { render :action => 'index' }
    end
  end

  def new
    @order = Order.find(params[:id])
    @user = user_profile
    @acquisition = Acquisition.new
    @acquisition.order_id = @order.id
    respond_to do |format|
      format.html { render :action => 'new' }
    end
  end

  def create
    @order = Order.find(params[:id])
    @user_profile = user_profile
    @acquisition = Acquisition.new(params[:acquisition])
    @acquisition.user_id = session[:user]
    
    respond_to do |format|
      if @acquisition.save
        format.html { redirect_to :action => "index" }
      else
        format.html { render "new", :id => @acquisition.order_id }
      end
    end
  end

  def show
    @order = OrderReporter.find_by_order_id(params[:id])
    respond_to do |format|
      format.html { render "show" }
      format.pdf  { render "show.rpdf" }
    end
  end

  def edit
    @order = Order.find(params[:id])
    @user = user_profile
    @acquisition = Acquisition.find_by_order_id(params[:id])

    respond_to do |format|
      format.html { render :action => 'edit'}
    end
  end

  def update
    @order = Order.find(params[:id])
    @acquisition = Acquisition.find_by_order_id(params[:id])
    @user = user_profile

    respond_to do |format|
      if @acquisition.update_attributes(params[:acquisition])
        format.html { redirect_to :action => "index" }
      else
        format.html { render 'new', :id => @acquisition.order_id }
      end
    end
  end

  private
  def user_profile
    UserProfileClient.find_by_login(User.find(session[:user]).login)
  end

end
