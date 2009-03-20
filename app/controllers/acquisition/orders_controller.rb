class Acquisition::OrdersController < ApplicationController

  layout "orders"

  def index
    @collection = Order.paginate(:all, :conditions => [ "order_status_id=3" ], :order => "date ASC" , :page => params[:page] || 1, :per_page => 20)
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
    @acquisition = Acquisition.new(params[:acquisition])
    @acquisition.user_id = session[:user]
    respond_to do |format|
      if @acquisition.save
        format.html { redirect_to :action => "index" }
      else
        format.html { redirect_to :action => "new", :id => @acquisition.order_id }
      end
    end
  end

  def show
    @order = Order.find(params[:id])
    @user = user_profile

    respond_to do |format|
      format.html { render :action => "show" }
    end
  end

  def show_pdf
    send_file File.join(RAILS_ROOT, 'tmp', 'documents', 'solicitud_compra_15.pdf'), :type => 'application/pdf', :disposition => 'inline'
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
    @acquisition = Acquisition.find_by_order_id(params[:id])

    respond_to do |format|
      if @acquisition.update_attributes(params[:acquisition])
        format.html { redirect_to :action => "index" }
      else
        format.html { redirect_to :action => "new", :id => @acquisition.order_id }
      end
    end
  end

  private
  def user_profile
    UserProfileClient.find_by_login(User.find(session[:user]).login)
  end

end
