class CurrencyController < ApplicationController
  def index
    respond_to do |format|
      format.html { render :action => :index }
    end
  end

  def new
    @currency = CurrencyClient.new("http://themoneyconverter.com/ES/USD/rss.xml")
  end

  def replace_value(currency_id)
    format.js { render :action => 'replace_value.rjs'}
    # @currency = CurrencyClient.new("http://themoneyconverter.com/ES/USD/rss.xml")
    # @currency.get_value
  end
end
