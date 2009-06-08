class ProviderSessionsController < ApplicationController
  skip_before_filter :login_required

  def create
    if Provider.authenticate?(params[:provider_id], params[:order_id], params[:token])
      session[:provider_id] = params[:provider_id]
      if OrderFile.find_by_order_id_and_provider_id(params[:order_id], params[:provider_id]).nil?
        redirect_to edit_estimate_file_path( :estimate_id=> params[:order_id], :id => params[:provider_id])
      else
        render :text => "Los archivos del proveedor #{Provider.find(params[:provider_id]).name} ya han sido cargados al sistema por el proveedor", :status => 401
      end
    else
      render 'unauthorized_message', :status => 401
    end
  end

  def destroy
    reset_session
    render 'destroy'
  end
end
