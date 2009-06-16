require File.dirname(__FILE__) + '/../test_helper'

class ApplicationControllerTest < ActionController::TestCase
  
  test "Should have login_required before filter" do
     assert_equal [ :login_required, :verify_authenticity_token ], ApplicationController.before_filters
  end

end
