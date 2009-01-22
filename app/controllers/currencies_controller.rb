class CurrenciesController < ApplicationController
  def index
    respond_to do |format|
      format.html { render :action => :index }
    end
  end

  def new
    @record = Currency.new

    respond_to do |format|
      format.js { render :action => 'new.rjs' }
    end
  end

   def create
     @record = Currency.new(params[:currency])
     respond_to do |format|
       if @record.valid?
         session[:currency] = @record
         session[:currency_order] = CurrencyOrder.new(params[:currency_order])
         format.js { render :action => 'create.rjs' }
       else
         format.js { render :action => 'errors.rjs' }
       end
     end
   end

   def show
     @record = Currency.find(params[:id])

     if @record.id < 6
       @currency = CurrencyClient.new(@record.url).get_value
       session[:currency] = @record
       session[:currency_order] = CurrencyOrder.new({:value => @currency})
     end

     respond_to do |format|
       format.js { render :action => 'show.rjs'}
     end
   end

 end
