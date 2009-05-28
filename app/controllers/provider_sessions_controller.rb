class ProviderSessionsController < ApplicationController
  skip_before_filter :login_required
  def create
    if authenticate?(params)
      session[:provider_id] = params[:provider_id]
      redirect_to edit_estimate_file_path(:estimate_id=>params[:order_id], :id => params[:provider_id])
    else
      render :text => "Para poder acceder al sitio debe acceder a través de la liga recibida a través de un correo electrónico", :status => 401
    end
  end

  def destroy
    session[:provider_id] = nil
    session[:order_id] = nil
    render :text => 'Good bye!'#, This method should display a fancy message
  end

  private 
  def authenticate?(params)
    @order = Order.find(params[:order_id])
    @provider = Provider.find(params[:provider_id])
    if !(@order.nil? and @provider.nil?)
      return true if params[:token] == User.encrypt([@order.id, @provider.id, @provider.created_at.to_s].join('_')).slice(0..9)
    end  
    return false
  end

end
