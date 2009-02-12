require File.dirname(__FILE__) + '/../test_helper'

class ProductCategoryTest < ActiveSupport::TestCase
  should_require_attributes :name
end
