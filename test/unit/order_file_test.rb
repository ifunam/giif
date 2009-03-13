require File.dirname(__FILE__) + '/../test_helper'

class OrderFileTest < ActiveSupport::TestCase
  should_validate_presence_of :file_type_id, :file
  should_belong_to :order
  should_belong_to :file_type
end
