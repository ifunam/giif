require File.dirname(__FILE__) + '/../test_helper'

class RoomTypeTest < ActiveSupport::TestCase
  fixtures :room_types

  should_validate_presence_of :name
  should_validate_uniqueness_of :name

  should_validate_numericality_of :id
end
