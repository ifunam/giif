require File.dirname(__FILE__) + '/../test_helper'

class RoomTest < ActiveSupport::TestCase
  should_require_attributes :building_id, :room_type_id
end
