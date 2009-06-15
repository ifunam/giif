require File.dirname(__FILE__) + '/../test_helper'

class ApplicationControllerTest < ActionController::TestCase
  fixtures :users
  
  include ActionView::Helpers
  include OrderHelper

  def setup
  end

  test "should get store_location" do 

  end
  
end
