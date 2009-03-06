require File.dirname(__FILE__) + '/../test_helper'

class RoomTest < ActiveSupport::TestCase
  should_validate_presence_of :building_id, :room_type_id
end
