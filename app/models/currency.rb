class Currency < ActiveRecord::Base
  validates_presence_of :name

  has_many :currency_orders
end
