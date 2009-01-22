class Currency < ActiveRecord::Base
  validates_presence_of :name, :url

  has_many :currency_orders

  def self.get_currency_data
    self.find(:first, :order => "id" )
  end

  def get_url
    Currency.find_by_name("Pesos").url
  end
end
