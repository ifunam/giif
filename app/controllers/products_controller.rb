class ProductsController < ApplicationController

  def destroy
     @record = Product.find(params[:id])
     @record.destroy
     respond_to do |format|
       format.js { render 'destroy.rjs' }
     end
   end

end
