class ProviderSessionsController < ApplicationController
  skip_before_filter :login_required

  def create
    if Provider.authenticate?(params[:provider_id], params[:order_id], params[:token])
      session[:provider_id] = params[:provider_id]
      redirect_to edit_estimate_file_path( :estimate_id=> params[:order_id], :id => params[:provider_id] )
    else
      render 'unauthorized_message', :status => 401
    end
  end

  def destroy
    reset_session
    render 'destroy'
  end
end
