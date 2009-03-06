require File.dirname(__FILE__) + '/../test_helper'

class BudgetTest < ActiveSupport::TestCase
  should_validate_presence_of :order_id, :user_id#, :code, :external_account, :previous_number
  should_belong_to :order
end
