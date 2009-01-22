require 'rubygems'
require 'pdf/writer'
require 'ruby-debug'
class OrderRequestsController < ApplicationController
  #  before_filter :authorize

  def index
    @collection = Order.paginate(:all, :conditions => {:user_id =>  session[:user]},:order => "date DESC" ,
                                                    :page => params[:page] || 1, :per_page => 20)
    respond_to do |format|
      format.html { render :action => :index }
    end
  end

  def new
    # @user_profile = user_profile
    @order = Order.new
    @order.date = Date.today
    @order.user_id = session[:user]
    1.times{ @order.order_products.build }
    @order.order_providers.build.provider = Provider.new
    @order.order_files << OrderFile.new
    @order.projects << Project.new
    @order.currency_order = CurrencyOrder.new
    @currencies = Currency.find(:all)
  end

  def create
    # @user_profile = user_profile
    @collection = Order.paginate(:all, :conditions => {:user_id =>  session[:user]},:order => "date DESC" ,
                                                    :page => params[:page] || 1, :per_page => 20)
    @order = Order.new(:order_status_id => 1, :date => Date.today)
    self.set_user(@order)
    @order.add_products(params[:products])
    @order.add_providers(params[:providers])
    @order.add_files(params[:files])
    @order.add_projects(params[:projects])
    @order.add_currency_data(session[:currency].id, session[:currency].name, session[:currency].url, session[:currency_order].value)
    if request.env['HTTP_CACHE_CONTROL'].nil?
      respond_to do |format|
        if @order.save
          format.html { redirect_to :action => "index" }
          format.xml  { render :xml => @order, :status => :created, :location => @order }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

   def send_order
    @order = Order.find(params[:id])
    respond_to do |format|
      if @order.change_to_sent_status
        Notifier.deliver_order_request_from_user(@order, user_profile)
        if UserProfileClient.find_by_login(:user).has_user_incharge?
          Notifier.deliver_order_to_userincharge(@order, user_incharge)
       end
        format.js { render :action => 'send_order.rjs'}
      else
        format.js  { render :action => 'errors.rjs' }
      end
    end
  end

  def edit
    # @user_profile = user_profile
    @order = Order.find(params[:id])
    respond_to do |format|
      format.html { render :action => 'edit'}
    end
  end

  def show
    # @user_profile = user_profile
    @order = Order.find(params[:id])
    @currencies = Currency.find(:all, :conditions => ["id=?", 6], :order => 'id')
    respond_to do |format|
      format.html { render :action => "show" }
    end
  end

  def update
    # @user_profile = user_profile
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

  def destroy_item
    @model = ActiveSupport::Inflector.camelize(params[:table]).constantize
    @record = @model.find(params[:id])
    @record.destroy
    respond_to do |format|
      format.js { render :action => 'destroy_item.rjs'}
    end
  end

  def get_file
    record = OrderFile.find(params[:id])
    send_data record.file, :type => record.content_type, :filename => record.filename, :disposition => 'attachment'
  end

  def get_currency_data
    @currency = CurrencyClient.new("http://themoneyconverter.com/ES/USD/rss.xml")
  end

  private
  def user_profile
    UserProfileClient.find_by_login(User.find(session[:user]).login)
  end

  def user_incharge
    UserProfileClient.find_by_login(User.find(session[:user]).login).user_incharge
  end

end
