class CurrenciesController < ApplicationController

  def show_currency
    @record = Currency.find(params[:id])

    if @record.id < 6
      value = @record.id > 1 ? CurrencyClient.new(@record.url, @record.conversion_title).value : 1
      session[:currency_order] = CurrencyOrder.new({:value => value, :currency_id => @record.id })
    end
    respond_to do |format|
      format.js { render :action => 'show.rjs'}
    end
  end

  def change_currency
    respond_to do |format|
      format.js { render :action => 'change_currency.rjs'}
    end
  end

#TODO: Insert this code in a general method
  def get_currency
    session[:order_id] = params[:order_id]   
    respond_to do |format|
      format.js { render :action => 'get_currency.rjs'}
    end    
  end

  def submit_currency
    @record = Currency.find(params[:id])

    if @record.id < 6
      value = @record.id > 1 ? CurrencyClient.new(@record.url, @record.conversion_title).value : 1
      session[:currency_order] = CurrencyOrder.new({:value => value, :currency_id => @record.id })
    end

    respond_to do |format|
      format.js { render :action => 'submit_currency.rjs'}
    end    
  end
#TODO

  def update_currency
    @order_reporter = OrderReporter.find_by_order_id(session[:order_id])
    @order = Order.find(session[:order_id])
    @order.currency_order.value = session[:currency_order].value
    @order.currency_order.currency_id = session[:currency_order].currency_id

    respond_to do |format|
      @order.save
      flash[:currency] = 'La divisa se ha actualizado'
      format.js { render :action => 'update_currency.rjs'}
    end    
  end

  def create_currency
    @currency_order = CurrencyOrder.new(:value => params[:currency_order][:value], :currency_id => 6)
    @currency = Currency.new(:name => params[:currency][:name], :url => params[:currency][:url])
    
    session[:currency_order] = @currency_order
    session[:currency_order].currency = @currency

     respond_to do |format|
      if @currency_order.valid?
        format.js { render :action => 'create_currency.rjs'}
      else
        format.js { render :action => 'errors.rjs'}
      end
    end
  end

end
