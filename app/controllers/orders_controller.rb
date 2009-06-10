require 'rubygems'
require 'pdf/writer'
require 'order_reporter'
class OrdersController < ApplicationController
  #  before_filter :authorize

  def index
    @user_profile = user_profile
    @collection = Order.paginate_by_orders(session[:user], params[:page], params[:per_page])

    respond_to do |format|
      format.html { render :index }
    end
  end

  def new
    @user_profile = user_profile
    @order = Order.new
    @order.providers.build  if @order.providers.size  > 0
    @order.products.build   if @order.products.size   == 0
    @order.files.build      if @order.files.size      == 0
    @order.projects.build   if @order.projects.size   == 0

    respond_to do |format|
        format.html { render :new }
    end
  end

  def create
    @user_profile = user_profile
    @order = Order.new(params[:order].merge(:order_status_id => 3, :date => Date.today, :user_id => session[:user]))
    @order.currency_order = session[:currency_order]
    if request.env['HTTP_CACHE_CONTROL'].nil?
      respond_to do |format|
        if @order.save
          format.html { redirect_to :action => "index" }
          format.xml  { render :xml => @order, :status => :created, :location => @order }
        else
          format.html { render :new }
          format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
        end

      end
    end
  end

  def send_data
    @user_profile = user_profile
    @order = Order.find(params[:id])
    respond_to do |format|
      @order.change_to_unsent_to_order
      format.js { render 'shared/send_order.rjs'}
    end
  end

  def edit
    @user_profile = user_profile
    @order = Order.find(params[:id])
    @order.files.build      if @order.files.size      == 0
    @order.projects.build   if @order.projects.size   == 0

    respond_to do |format|
      format.html { render 'edit' }
    end
  end

  def show
    @order = OrderReporter.find_by_order_id(params[:id])
    respond_to do |format|
      format.html { render "show" }
      format.pdf  { render "show.rpdf" }
    end
  end

  def show_preview
    @order = OrderReporter.find_by_order_id(params[:id])
    respond_to do |format|
      format.html { render "show_preview"}
    end
  end

  def update
    @user_profile = user_profile
    @order = Order.find(params[:id])
    @order.currency_order = session[:currency_order] if @order.currency_order.nil?

    if request.env['HTTP_CACHE_CONTROL'].nil?
      respond_to do |format|
        if @order.update_attributes(params[:order])
          format.html { redirect_to :action => 'index'}
          format.xml  { render :xml => @order, :status => :updated, :location => @order }
        else
          format.html { render "edit" }
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
      format.js { render 'destroy_item.rjs'}
    end
  end

  def get_file
    record = OrderFile.find(params[:id])
    send_data record.file, :type => record.content_type, :filename => record.filename, :disposition => 'attachment'
  end

end
