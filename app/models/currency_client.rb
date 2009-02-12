require 'rubygems'
require '/usr/lib/ruby/gems/1.8/gems/feedtools-0.2.29/lib/feed_tools.rb'
#require 'feed_tools'
class CurrencyClient
  attr_accessor :value, :description

  def self.find(url)
    self.new(url)
  end

  def initialize(url,title=nil)
    @url = url
    @title = title || "Title: #{title}"
    @description = nil
    @value = nil
    @resource = nil
  end

  def get_resource
    @resource= FeedTools::Feed.open(@url)
  end

  def get_description
    for i in 0..@resource.items.size - 1
      if @resource.items[i].description.include? "Peso Mexicano"
        @description =  @resource.items[i].description
        break
      end
    end
  end

  def get_value
    get_resource
    get_description
    if @description.split(/\ /)[1] == "Peso"
      @value = 1
    else
      @value = @description.split(/\ /)[4]
    end

  end

  def convert(amount)
    get_value
    @value.to_f * amount.to_f
  end
end
