class Product < ActiveRecord::Base
  validates_presence_of :product_type_id, :model, :vendor
end
