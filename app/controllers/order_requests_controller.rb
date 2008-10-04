require 'ruby-debug'
class OrderRequestsController < ApplicationController
  auto_complete_for :order_product, :description
  #  before_filter :authorize
  def setup
    @select = Order.find(2).id
  end

  def index
    @collection = Order.paginate(:all, :conditions => {:user_id =>  session[:user]},:order => "date DESC" ,
    :page => params[:page] || 1, :per_page => 20)
    respond_to do |format|
      format.html { render :action => :index }
    end
  end

  def new
    @user_profile = user_profile
    @order = Order.new
    @order.date = Date.today
    @order.user_id = session[:user]
    1.times{ @order.order_products.build }
    @order.order_providers.build.provider = Provider.new
    @order.order_files << OrderFile.new
    @order.projects << Project.new
  end

  def create
    @user_profile = user_profile
    @order = Order.new(:order_status_id => 1, :date => Date.today)
    self.set_user(@order)
    @order.add_products(params[:products])
    @order.add_providers(params[:providers])
    @order.add_files(params[:files])
    @order.add_projects(params[:projects])
    if request.env['HTTP_CACHE_CONTROL'].nil?
      respond_to do |format|
        if @order.save
          Notifier.deliver_order_request(@order, user_profile)
          format.html { render :action => "show" }
          format.xml  { render :xml => @order, :status => :created, :location => @order }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  def edit
    @user_profile = user_profile
    @order = Order.find(params[:id])
    respond_to do |format|
      format.html { render :action => 'edit'}
    end
  end

  def show
    @user_profile = user_profile
    @order = Order.find(params[:id])
    respond_to do |format|
      format.html { render :action => "show" }
    end
  end

  def update
    @user_profile = user_profile
    @order = Order.find(params[:id])
    @order.add_products(params[:products])
    @order.add_providers(params[:providers])
    @order.add_files(params[:files])
    @order.add_projects(params[:projects])
    if request.env['HTTP_CACHE_CONTROL'].nil?
      respond_to do |format|
        if @order.save
          format.html { render :action => "show" }
          format.xml  { render :xml => @order, :status => :created, :location => @order }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  def destroy
    @order = Order.find(params[:id])

    @order.destroy unless @order.order_status == 1

    respond_to do |format|
      format.html { redirect_to :action => 'index' }
    end
  end

  def destroy_file
    @order_file = OrderFile.find(params[:id])
    @order_file.destroy
    respond_to do |format|
      format.js { render :action => 'destroy_file.rjs'}
    end
  end

  def destroy_project
    @project = Project.find(params[:id])
    @project.destroy
    respond_to do |format|
      format.js { render :action => 'destroy_project.rjs'}
    end
  end

  def get_file
    record = OrderFile.find(params[:id])
    send_data record.file, :type => record.content_type, :filename => record.filename, :disposition => 'attachment'
  end

  private
  def user_profile
    UserProfileClient.find_by_login(User.find(session[:user]).login)
  end
end
