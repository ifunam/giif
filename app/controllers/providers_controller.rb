class ProvidersController < ApplicationController
  
  def destroy
    @record = Provider.find(params[:id])
    @record.destroy
    respond_to do |format|
      format.js { render 'destroy.rjs' }
    end
  end
end
