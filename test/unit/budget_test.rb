require File.dirname(__FILE__) + '/../test_helper'

class BudgetTest < ActiveSupport::TestCase
  should_require_attributes :order_id, :user_id#, :code, :external_account, :previous_number
  should_belong_to :order
end
