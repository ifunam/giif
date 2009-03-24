require File.dirname(__FILE__) + '/../test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products
  
  should_validate_presence_of :product_type_id, :model, :vendor
end
