class Budget::OrdersController < ApplicationController

  layout "orders"

  def index
    @user_profile = user_profile
    @collection = Order.paginate_for_budget_backend(session[:user], params[:page], params[:per_page])
    respond_to do |format|
      format.html { render :action => 'index' }
    end
  end

  def approve
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.approve
        Notifier.deliver_request_approved(@order)
        format.js { render :action => 'approve.rjs'}
      else
        format.js  { render :action => 'errors.rjs' }
      end
    end
  end


  def reject
    @order = Order.find(params[:id])
    
    respond_to do |format|
      if @order.reject
        Notifier.deliver_order_request_rejected(@order)
        format.js { render :action => 'reject.rjs'}
      else
        format.js  { render :action => 'errors.rjs' }
      end
    end
  end
  
  def new
    @order = Order.find(params[:id])
    @user = user_profile
    @budget = Budget.new
    @budget.order_id = @order.id
  end

  def edit
    @order = Order.find(params[:id])
    @user = user_profile
    @budget = Budget.find_by_order_id(params[:id])
  end

  def create
    @budget = Budget.new(params[:budget])
    @budget.user_id = session[:user]

    @order = Order.find(params[:id])

    respond_to do |format|
      if @budget.save
        @order.change_status(7)
        format.html { redirect_to :action => "index" }
      else
        format.html { render :action => "new", :id => @budget.order_id }
      end
    end
  end

  def update
    @budget = Budget.find_by_order_id(params[:id])

    respond_to do |format|
      if @budget.update_attributes(params[:budget])
        format.html { redirect_to :action => "index" }
      else
        format.html { redirect_to :action => "new", :id => @budget.order_id }
      end
    end
  end

  def update_currency_order
    @order =  Order.find(session[:order])
    @currency_order = CurrencyOrder.find_by_order_id(session[:order])
    @currency_order.currency_id = session[:currency_order].currency_id
    @currency_order.value = session[:currency_order].value
  
    respond_to do |format|
      if @currency_order.save
        format.js { render :action => 'update_currency_order.rjs'}
      else
        #
      end
    end
  end

  def show_currency
    # @order = Order.find(params[:id])
    @currencies = Currency.find(:all, :conditions => ['id <= ?', 6])

    respond_to do |format|
      format.js { render :action => 'change_currency.rjs'}
    end
  end


  def show_pdf
    send_file File.join(RAILS_ROOT, 'tmp', 'documents', "solicitud_compra_" + params[:id]  + ".pdf"), :type => 'application/pdf', :disposition => 'inline'
  end

  private
  def user_profile
    UserProfileClient.find_by_login(User.find(session[:user]).login)
  end

end
