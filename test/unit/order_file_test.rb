require File.dirname(__FILE__) + '/../test_helper'

class OrderFileTest < ActiveSupport::TestCase
  should_require_attributes :file_type_id, :file, :content_type, :filename
  should_belong_to :order
  should_belong_to :file_type
end
