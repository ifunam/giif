class CurrenciesController < ApplicationController
  def index
    respond_to do |format|
      format.html { render :action => :index }
    end
  end

  def get_data
#     @order = Order.new
#     1.times{ @order.order_products.build }
#     if params[:id] == 5
#       respond_to do |format|
#         format.js { render :action => 'get_data.rjs' }
#       end
#     end
  end

   def create
     respond_to do |format|
       format.js { render :action => 'create.rjs' }
     end
   end

   def show
     if params[:id] == 6
       respond_to do |format|
         format.js { render :action => 'create.rjs'}
       end
     else
       @record = Currency.find(params[:id])
       @currency = CurrencyClient.new(@record.url)
       respond_to do |format|
         format.js { render :action => 'show.rjs'}
       end
     end
   end


end
