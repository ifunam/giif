class CurrencyOrder < ActiveRecord::Base
  validates_presence_of :value, :currency_id

  belongs_to :order
  belongs_to :currency
end
