class Budget::OrdersController < ApplicationController

  layout "orders"

  def index
    @user_profile = user_profile
    @collection = Order.paginate_orders_for_budget_backend(session[:user], params[:page], params[:per_page])
    respond_to do |format|
      format.html { render :action => 'index' }
    end
  end

  def approve
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.approve
        format.js { render :action => 'replace_data.rjs'}
      else
        format.js  { render :action => 'errors.rjs' }
      end
    end
  end


  def reject
    @order = Order.find(params[:id])
    
    respond_to do |format|
      if @order.reject
        format.js { render :action => 'replace_data.rjs'}
      else
        format.js { render :action => 'errors.rjs' }
      end
    end
  end
  
  def new
    @order = Order.find(params[:id])
    @user = user_profile
    @budget = Budget.new
    @budget.order_id = @order.id
  end

  def create
    @budget = Budget.new(params[:budget])
    @budget.user_id = session[:user]
    @user = user_profile

    @order = Order.find(params[:id])

    respond_to do |format|
      if @budget.save
        @order.approve
        format.html { redirect_to :action => "index" }
      else
        format.html { render 'new', :id => @budget.order_id }
      end
    end
  end

  def update
    @budget = Budget.find_by_order_id(params[:id])
    @order = Order.find(params[:id])

    respond_to do |format|
      if @budget.update_attributes(params[:budget])
        format.html { redirect_to :action => "index" }
      else
        format.html { render 'new', :id => @budget.order_id }
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

  private
  def user_profile
    UserProfileClient.find_by_login(User.find(session[:user]).login)
  end

end
