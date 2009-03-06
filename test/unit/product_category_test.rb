require File.dirname(__FILE__) + '/../test_helper'

class ProductCategoryTest < ActiveSupport::TestCase
  should_validate_presence_of :name
end
