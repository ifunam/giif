class Budget::OrderRequestsController < ApplicationController
  def index
    @collection = Order.paginate(:all, :order => "date ASC" , :page => params[:page] || 1, :per_page => 20)
    respond_to do |format|
      format.html { render :action => 'index' }
    end
  end
end
