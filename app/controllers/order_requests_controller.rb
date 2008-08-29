class OrderRequestsController < ApplicationController
  auto_complete_for :order_product, :description
#  before_filter :authorize
  def index
    @collection = Order.paginate(:all, :conditions => {:user_id =>  session[:user]},:order => "date DESC" ,
                                                   :page => params[:page] || 1, :per_page => 20)
    respond_to do |format|
      format.html { render :action => :index }
    end
  end

  def new
    @order = Order.new
    @order.date = Date.today
    @order.user_id = session[:user]
    1.times{ @order.order_products.build }
    @order.order_providers.build.provider = Provider.new
    @order.order_files << OrderFile.new
  end

  def create
    @order = Order.new(:order_status_id => 1, :date => Date.today)
    self.set_user(@order)
    @order.add_products(params[:products])
    @order.add_providers(params[:providers])
    @order_file =  OrderFile.new(params[:order_files] )
    set_file
    @order.order_files <<  @order_file

    respond_to do |format|
      if @order.save
        Notifier.deliver_order_request(@order)
        format.html { render :action => "show" }
        format.xml  { render :xml => @order, :status => :created, :location => @order }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
   end

  def edit
    @order = Order.find(params[:id])
    respond_to do |format|
      format.html { render :action => 'edit'}
    end
  end

  def show
    @order = Order.find(params[:id])
    respond_to do |format|
      format.html { render :action => "show" }
    end
  end

  def update
     @order = Order.find(params[:id])
     @order.add_products(params[:products])
     @order.add_providers(params[:providers])
#     @order_file =  OrderFile.new(params[:order_files] )
#     set_file
#     @order.order_files <<  @order_file

    respond_to do |format|
#       if @order.save
#         #Notifier.deliver_order_request(@order)
         format.html { render :action => "show" }
#         format.xml  { render :xml => @order, :status => :created, :location => @order }
#       else
#         format.html { render :action => "edit" }
#         format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
       end
#     end
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    respond_to do |format|
      format.html { redirect_to :action => 'index' }
    end
  end

  def get_file
    record = OrderFile.find(params[:id])
    send_data record.file, :type => record.content_type, :filename => record.filename, :disposition => 'attachment'
  end

private
  def set_file
    file = params[:order_files][:file]
    if !file.nil? && (file.class == ActionController::UploadedTempfile || file.class == ActionController::UploadedStringIO)
      @order_file.file = file.read
      @order_file.content_type = file.content_type.chomp.to_s
      @order_file.filename = file.original_filename.chomp
    end
  end
end
