class OrderProduct < ActiveRecord::Base
  validates_presence_of :quantity, :description, :price_per_unit #:unit
  validates_numericality_of :quantity, :only_integer => true, :greater_than => 0
  validates_numericality_of :price_per_unit,  :greater_than => 0

  belongs_to :order
  belongs_to :user

end
