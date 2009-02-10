class Budget::OrderRequestsController < ApplicationController

  layout "budget_order_request"

  def index
    @collection = Order.paginate(:all, :conditions => [ "order_status_id>1" ], :order => "date ASC" , :page => params[:page] || 1, :per_page => 20)
    respond_to do |format|
      format.html { render :action => 'index' }
    end
  end

  def approve
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.change_to_approved_status
        Notifier.deliver_request_approved(@order) #, user_profile)
        format.js { render :action => 'approve.rjs'}
      else
        format.js  { render :action => 'errors.rjs' }
      end
    end
  end

  def reject
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.change_to_rejected_status
        Notifier.deliver_order_request_rejected(@order) #, user_profile)
        format.js { render :action => 'reject.rjs'}
      else
        format.js  { render :action => 'errors.rjs' }
      end
    end
  end

  def add_data
    @order = Order.find(params[:id])
    @user = user_profile
    @order.budget = Budget.new
  end

  def edit
    @order = Order.find(params[:id])
    @user = user_profile
    @order.budget = Budget.find_by_order_id(params[:id])
  end

  def create
    @collection = Order.paginate(:all, :conditions => [ "order_status_id=2" ], :order => "date ASC" , :page => params[:page] || 1, :per_page => 20)
    @order = Order.find(params[:id])
    @order.add_budget_data(params[:budget], session[:user])

    respond_to do |format|
      if @order.budget.valid?
        @order.save
        format.html { redirect_to :action => "index" }
      else
        format.html { render :action => "add_data", :id => @order.id }
      end
    end
  end

  def update
    @collection = Order.paginate(:all, :conditions => [ "order_status_id=2" ], :order => "date ASC" , :page => params[:page] || 1, :per_page => 20)
    @order = Order.find(params[:id])
    @order.add_budget_data(params[:budget], session[:user])

    respond_to do |format|
      if @order.budget_data.valid?
        @order.save
        format.html { redirect_to :action => "index" }
      else
        format.html { redirect_to :action => 'index' }
      end
    end
  end

  def show_currency
    @order = Order.find(params[:id])
    @currencies = Currency.find(:all, :conditions => ['id <= ?', 6])

    respond_to do |format|
      format.js { render :action => 'change_currency.rjs'}
    end
  end

  def change_currency

  end

 def show_pdf
   send_file File.join(RAILS_ROOT, 'tmp', 'documents', 'solicitud_compra_15.pdf'), :type => 'application/pdf', :disposition => 'inline'
 end

  private
  def user_profile
    UserProfileClient.find_by_login(User.find(session[:user]).login)
  end

end
