require File.dirname(__FILE__) + '/../test_helper'
class AuthenticationClientTest < Test::Unit::TestCase
  remote_fixtures
  def test_should_authenticate_valid_users
    assert AuthenticationClient.authenticate?('alex', 'valid_password')
  end
  
  def test_should_not_authenticate_invalid_users
    assert !AuthenticationClient.authenticate?('alex', 'invalid_password')
  end
end
