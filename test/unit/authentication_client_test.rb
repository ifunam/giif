require File.dirname(__FILE__) + '/../test_helper'
require 'active_resource'
require 'active_resource/http_mock'
class AuthenticationClientTest < Test::Unit::TestCase
  def setup
    @valid_auth = { :authentication => true }.to_xml(:root => :user) 
    @invalid_auth = { :authentication => false }.to_xml(:root => :user) 
    ActiveResource::HttpMock.respond_to do |mock|
          mock.get    "/sessions/login.xml?login=juancho&passwd=valid_password", {}, @valid_auth
          mock.get    "/sessions/login.xml?login=invalid_user&passwd=invalid_password", {}, @invalid_auth
    end
  end
  
  def test_should_authenticate_valid_users
    assert AuthenticationClient.authenticate?('juancho', 'valid_password')
  end
  
  def test_should_not_authenticate_invalid_users
    assert !AuthenticationClient.authenticate?('invalid_user', 'invalid_password')
  end
end
