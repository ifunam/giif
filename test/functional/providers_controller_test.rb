require File.dirname(__FILE__) + '/../test_helper'

class ProvidersControllerTest < ActionController::TestCase
  fixtures :users, :providers
  
  def test_should_destroy_existing_provider
    session[:user] = User.find_by_login('fernando').id
    assert Provider.find(1)

    delete :destroy, :id => 1
    assert_template  'destroy.rjs'
  end
end
