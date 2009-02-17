class CurrencyOrder < ActiveRecord::Base
  validates_presence_of :value, :order_id, :currency_id

  belongs_to :order
  belongs_to :currency
end
