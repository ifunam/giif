class Budget::OrderRequestsController < ApplicationController

  layout "budget_order_request"

  def index
    @collection = Order.paginate(:all, :conditions => [ "order_status_id=2" ], :order => "date ASC" , :page => params[:page] || 1, :per_page => 20)
    respond_to do |format|
      format.html { render :action => 'index' }
    end
  end

  def show
    @order = Order.find(params[:id])
  end

end
