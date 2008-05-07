class ProductType < ActiveRecord::Base
  validates_presence_of :name, :product_category_id
  validates_uniqueness_of :name
end
