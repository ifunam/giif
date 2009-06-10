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
