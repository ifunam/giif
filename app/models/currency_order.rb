class CurrencyOrder < ActiveRecord::Base
  validates_presence_of :order_id, :currency_id, :value

  belongs_to :order
  belongs_to :currency
end
