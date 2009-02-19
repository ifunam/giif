require File.dirname(__FILE__) + '/../test_helper'
require 'flexmock/test_unit'
class AuthenticationClientTest < ActiveSupport::TestCase

  def test_authenticate
    flexmock(AuthenticationClient).should_receive(:authenticate?).with('alex','qw12..').and_return(true)
    assert AuthenticationClient.authenticate?('alex', 'qw12..')
  end
end
