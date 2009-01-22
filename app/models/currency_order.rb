class CurrencyOrder < ActiveRecord::Base
  validates_presence_of :value

  belongs_to :order
  belongs_to :currency
end
