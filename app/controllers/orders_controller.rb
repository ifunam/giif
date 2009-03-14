require 'rubygems'
require 'pdf/writer'
require 'order_reporter'
class OrdersController < ApplicationController
  #  before_filter :authorize

  def index
    @collection = Order.paginate(:all, :conditions => {:user_id =>  session[:user]},:order => "date ASC" ,
                                                    :page => params[:page] || 1, :per_page => 20)
    respond_to do |format|
      format.html { render :action => :index }
    end
  end

  def new
    @user_profile = user_profile
    @order = Order.new
    @order.files.build
    @order.build_project
    @order.products.build
    @order.providers.build
#    @order.currency_order = CurrencyOrder.new
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
          format.html { render :text => @order.errors.full_messages.to_sentence }
          format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
        end

      end
    end
  end

  def send_order
    @user_profile = user_profile
    @order = Order.find(params[:id])
    respond_to do |format|
      if @order.sent
        format.js { render :action => 'send_order.rjs'}
      else
        format.js  { render :action => 'errors.rjs' }
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
    @order = OrderReporter.find_by_order_id(params[:id])
    respond_to do |format|
      format.html { render :action => "show"}
      format.pdf  { render :action => "show.rpdf" }
    end
  end

  def show_preview
    @order = OrderReporter.find_by_order_id(params[:id])
    respond_to do |format|
      format.html { render :action => "show_preview"}
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
          format.html { redirect_to :action => "show", :id => @order.id }
          format.xml  { render :xml => @order, :status => :updated, :location => @order }
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

  private
  def user_profile
    UserProfileClient.find_by_login(User.find(session[:user]).login)
  end

  def user_incharge
    UserProfileClient.find_by_login(User.find(session[:user]).login).user_incharge
  end

  def generate_pdf
    @document = DocumentGenerator.new(@order, @user_profile)
    @document.to_pdf
  end

end
