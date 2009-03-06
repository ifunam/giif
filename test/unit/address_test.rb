require File.dirname(__FILE__) + '/../test_helper'

class AddressTest < ActiveSupport::TestCase
   fixtures :addresses

  should_validate_presence_of :user_id, :location
  should_validate_uniqueness_of :user_id

  should_validate_numericality_of :id,:user_id
  should_not_allow_zero_or_negative_number_for :id, :user_id

  should_belong_to :user
end
