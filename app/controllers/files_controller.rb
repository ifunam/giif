class FilesController < ApplicationController
skip_before_filter :login_required
before_filter :session_provider_required

  def index
    @order = Order.find(params[:order_id])

    respond_to do |format|
      format.html { render 'index'}
    end
  end

  def edit
    #TODO: redirect to :message in case that provider_id and session[:provider_id] are nil
    #    @provider = Provider.find(session[:provider_id])
    #    @files = OrderFile.all(:conditions => ['order_id = ? AND provider_id = ?', params[:id], session[:provider_id]])

    @order = Order.find(params[:order_id])
    @order_reporter = OrderReporter.find_by_order_id(params[:order_id])
#    @order.files.build


    respond_to do |format|
      format.html { render 'edit'}
    end
  end

  def update
    @order = Order.find(params[:id])
    @order_reporter = OrderReporter.find_by_order_id(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])
        #send notification email
        format.html { redirect_to 'index', :id => @order.id}
      else
        format.html { render 'edit', :id => @order.id}
      end

    end
    
  end

  def show
#    @order
#    @provider
  end

  def destroy
  end

  def notify_to_user
    #upload file
    #notify to user by e-mail
  end

  private
  def session_provider_required
     (!session[:provider_id].nil? and !Provider.find(session[:provider_id]).nil?) ? (return true) : (return false)
  end

end
