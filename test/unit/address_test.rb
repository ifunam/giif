require File.dirname(__FILE__) + '/../test_helper'

class AddressTest < ActiveSupport::TestCase
   fixtures :addresses

  should_require_attributes :user_id, :location
  should_require_unique_attributes :user_id

  should_only_allow_numeric_values_for :id,:user_id
  should_not_allow_zero_or_negative_number_for :id, :user_id

  should_belong_to :user
end
