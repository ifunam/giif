require File.dirname(__FILE__) + '/../test_helper'

class AuthenticationClientTest < ActiveSupport::TestCase
  fixtures :users

  def setup
    @client = AuthenticationClient.new
    @client.attributes = {
                                   'login' => 'alex',
                                   'passwd' => 'qw12..'}
  end

  def test_authenticate
    assert AuthenticationClient.authenticate?(@client.login, @client.passwd)
  end
end
