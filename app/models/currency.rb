class Currency < ActiveRecord::Base
  validates_presence_of :name, :url

  has_many :currency_orders
end
