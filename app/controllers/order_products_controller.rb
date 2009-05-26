class OrderProductsController < ApplicationController
  def destroy
     @record = OrderProduct.find(params[:id])
     @record.destroy
     respond_to do |format|
       format.js { render 'destroy.rjs' }
     end
   end
end
