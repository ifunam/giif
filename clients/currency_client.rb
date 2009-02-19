require 'rubygems'
require 'simple-rss'
require 'open-uri'
class CurrencyClient
  attr_accessor :item
  def self.find(url)
    self.new(url)
  end

  def initialize(url,conversion_title=nil)
    @url = url
    @conversion_title = conversion_title || 'USD/MXN'
  end

  def set_conversion(conversion_title)
    @conversion_title = conversion_title
  end
  
  def get_item
    @resource = SimpleRSS.parse open(@url)  
    @resource.items.each do |item|
        @item = item and break if item[:title] == @conversion_title
    end
    @item
  end

  def get_value
    get_item[:description].split(' = ').last.split(' ').first.to_f
  end

  def convert(amount)
    get_value * amount.to_f
  end
end
