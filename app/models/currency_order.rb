class CurrencyOrder < ActiveRecord::Base
  validates_presence_of :value, :currency_id
  validates_numericality_of :value, :greater_than => 0

  belongs_to :order
  belongs_to :currency
end
