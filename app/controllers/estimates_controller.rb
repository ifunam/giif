class EstimatesController < ApplicationController
  def index
    @user_profile = user_profile
    @collection = Order.paginate_unsent_by_user_id(session[:user], params[:page], params[:per_page])
    respond_to do |format|
      format.html { render :index }
    end
  end

  def new
    @user_profile = user_profile
    @order = Order.new
    respond_to do |format|
      format.html { render :new }
    end
  end

  def create
    @order = Order.new(params[:order].merge(:date => Date.today, :user_id => session[:user]))
    respond_to do |format|
      if @order.save
        format.html { redirect_to :action => "index" }
        format.xml  { render :xml => @order, :status => :created, :location => @order }
      else
        format.html { render :new }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
  end
 
  def edit
     @user_profile = user_profile
     @order = Order.find(params[:id])
     respond_to do |format|
       format.html { render 'edit' }
     end
  end
  
  def update
    @order = Order.find(params[:id])
    @order.attributes = params[:order]
    respond_to do |format|
        if @order.save
          format.html { redirect_to :action => "index" }
          format.xml  { render :xml => @order, :status => :updated, :location => @order }
        else
          format.html { render "edit" }
          format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
        end
    end
  end

  def destroy
  end

end
