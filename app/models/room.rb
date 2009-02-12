class Room < ActiveRecord::Base
  validates_presence_of :building_id, :room_type_id
end
