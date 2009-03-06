require File.dirname(__FILE__) + '/../test_helper'

class AcquisitionTest < ActiveSupport::TestCase
  fixtures :acquisitions

  should_validate_presence_of :order_id, :user_id, :direct_adjudication_type_id
  should_allow_values_for :is_subcomittee_invitation, :is_subcomittee_bid, true, false
  should_belong_to :order
  should_belong_to :direct_adjudication_type
end
