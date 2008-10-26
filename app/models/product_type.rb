class ProductType < ActiveRecord::Base
  validates_presence_of :name, :product_category_id
  validates_uniqueness_of :name
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
end
