class FilesController < ApplicationController
  before_filter :session_provider_required
  skip_before_filter :login_required
  
  helper :all
  
  def edit
    #el token debe funcionar solo una vez
    @order = Order.find(params[:estimate_id])
    @order_reporter = OrderReporter.find_by_order_id(params[:estimate_id])

    respond_to do |format|
      format.html { render 'edit'}
    end
  end

  def update
    @order = Order.find(params[:id])
    @order_reporter = OrderReporter.find_by_order_id(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])
        format.html { redirect_to :controller => 'provider_sessions', :action => 'destroy', :id => @order.id}
      else
        format.html { render 'edit', :id => @order.id}
      end

    end
    
  end

  private
  def session_provider_required
    !session[:provider_id].nil? ? (return true) : (redirect_to :controller=> :provider_sessions, :action => 'unauthorized' and return false)
  end

end
