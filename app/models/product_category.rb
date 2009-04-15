class ProductCategory < ActiveRecord::Base
  validates_presence_of :name

  has_many :order_products
end
