class ProviderSessionsController < ApplicationController
  skip_before_filter :login_required
  def create
    if authenticate?(params)
      session[:provider_id] = params[:provider_id]
      redirect_to edit_estimate_file_path(:estimate_id=>params[:order_id], :id => params[:provider_id])
    else
      redirect_to :action => 'unauthorized'
    end
  end

  def unauthorized
    respond_to do |format|
      format.html { render 'unauthorized_message'}
    end
  end

  def destroy
    session[:provider_id] = nil
    session[:order_id] = nil
    render 'destroy'
  end

  def unauthorized
    respond_to do |format|
      format.html { render 'unauthorized_message'}
    end
  end

  private 
  def authenticate?(params)
    if !(params[:order_id].nil? and params[:provider_id].nil?)
      @order = Order.find(params[:order_id])
      @provider = Provider.find(params[:provider_id])
      return true if params[:token] == User.encrypt([@order.id, @provider.id, @provider.created_at.to_s].join('_')).slice(0..9)
    end  
    return false
  end

end
