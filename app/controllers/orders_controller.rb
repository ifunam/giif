require 'rubygems'
require 'pdf/writer'
require 'order_reporter'
class OrdersController < ApplicationController
  #  before_filter :authorize

  def index
    @collection = Order.paginate(:all, :conditions => {:user_id =>  session[:user]},:order => "date ASC" ,
                                                    :page => params[:page] || 1, :per_page => 20)
    respond_to do |format|
      format.html { render :index }
    end
  end

  def new
    @user_profile = user_profile
    @order = Order.new
    respond_to do |format|
        format.html { render :new }
    end
  end

  def create
    @user_profile = user_profile
    @order = Order.new(params[:order].merge(:order_status_id => 1, :date => Date.today, :user_id => session[:user]))
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

  def send_order
    @user_profile = user_profile
    @order = Order.find(params[:id])
    respond_to do |format|
      @order.sent
      format.js { render 'send_order.rjs'}
    end
  end

  def edit
    @user_profile = user_profile
    @order = Order.find(params[:id])
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

  def show_pdf
    send_file File.join(RAILS_ROOT, 'tmp', 'documents', "solicitud_compra_"+params[:id]+".pdf"), :type => 'application/pdf', :disposition => 'inline'    
  end

  def update
    @user_profile = user_profile
    @order = Order.find(params[:id])
    if request.env['HTTP_CACHE_CONTROL'].nil?
      respond_to do |format|
        if @order.update_attributes(params[:order])
          format.html { redirect_to "show", :id => @order.id }
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
