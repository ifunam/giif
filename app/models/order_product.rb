class OrderProduct < ActiveRecord::Base
  validates_presence_of :quantity, :description, :price_per_unit #:unit
  validates_numericality_of :quantity, :only_integer => true, :greater_than => 0
  validates_numericality_of :price_per_unit,  :greater_than => 0

  belongs_to :order
  belongs_to :user

  class << self
    def valid_options
      { :order_id => 13, :quantity => 2, :description => 'Product X', :price_per_unit => 200.00}
    end

    def build_valid
      OrderProduct.new(OrderProduct.valid_options)
    end
  end

end
