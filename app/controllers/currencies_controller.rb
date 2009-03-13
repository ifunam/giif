class CurrenciesController < ApplicationController

  def new
    @record = Currency.new
    respond_to do |format|
      format.js { render :action => 'new.rjs' }
    end
  end

  def create
    @currency_order = CurrencyOrder.new(params[:currency_order])
    @currency_order.currency = Currency.new(params[:currency])
    respond_to do |format|
      session[:currency_order] = @currency_order
      if !@currency_order.value.nil?
        format.js { render :action => 'create.rjs' }
      else
        format.js { render :action => 'errors.rjs' }
      end
    end
  end

  def show
    @record = Currency.find(params[:id])
    if @record.id < 6
      value = @record.id > 1 ? CurrencyClient.new(@record.url, @record.conversion_title).value : 1
      session[:currency_order] = CurrencyOrder.new({:value => value, :currency_id => @record.id })
    end
    respond_to do |format|
      format.js { render :action => 'show.rjs'}
    end
  end

  def add_currency_data
    @order = Order.find(session[:order])

    if Currency.exists?(params[:currency]) 
      @currency = Currency.find(:first, :conditions => {:name => params[:currency]['name'], :url => params[:currency]['url']})
    else
      @currency = Currency.new(params[:currency])
      @currency.save

    end

    @currency_order = CurrencyOrder.find_by_order_id(session[:order])
    @currency_order.currency_id = @currency.id
    @currency_order.value = params[:currency_order]['value']
    @currency_order.save

    respond_to do |format|
      format.js { render :action => 'update_form.rjs', :id => session[:order]}
    end
  end

  def change_currency
    respond_to do |format|
      format.js { render :action => 'change_currency.rjs'}
    end
  end

  def update
    @order = Order.find(params[:id])
    session[:order] = params[:id]
    @currency_order = CurrencyOrder.find_by_order_id(params[:id])

    respond_to do |format|
      format.js { render :action => 'update.rjs'}
    end
  end

  def update_currency_order
    @record = Currency.find(params[:id])
    if @record.id == 6
    else
      @currency_order = CurrencyClient.new(@record.url, @record.conversion_title)
      session[:currency_order] = CurrencyOrder.new({:value => @currency_order.value, :currency_id => @record.id})
    end

    respond_to do |format|
      format.js { render :action => 'update_currency_order.rjs'}
    end
  end


  def cancel
    respond_to do |format|
      format.js { render :action => 'change_currency.rjs'}
    end     
  end

  def clear
    respond_to do |format|
      format.js { render :action => 'clear.rjs'}
    end     
  end

end
