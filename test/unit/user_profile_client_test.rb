require File.dirname(__FILE__) + '/../test_helper'
require 'rubygems'
require 'activeresource'
require 'flexmock/test_unit'
class UserProfileClientTest < Test::Unit::TestCase
  def setup
    @user_profile = UserProfileClient.new
  end

  def test_find_by_login
    flexmock(UserProfileClient).should_receive(:find_by_login).with('alex').and_return(@user_profile)
    assert_instance_of UserProfileClient, UserProfileClient.find_by_login('alex')
  end

  def test_find_by_user_id
    flexmock(UserProfileClient).should_receive(:find_by_user_id).with(167).and_return(@user_profile)
    assert_instance_of UserProfileClient, UserProfileClient.find_by_user_id(167)
  end

  def test_fullname
    mock_for_method(:fullname, "Juárez Robles Jesús Alejandro")
    assert_equal "Juárez Robles Jesús Alejandro", @user_profile.fullname
  end

  def test_adscription_name
    mock_for_method(:adscription_name, "Apoyo")
    assert_equal "Apoyo", @user_profile.adscription_name
  end

  def test_adscription_id
    mock_for_method(:adscription_id, 7)
    assert_equal 7, @user_profile.adscription_id
  end

  def test_remote_user_id
    mock_for_method(:remote_user_id, 167)
    assert_equal 167, @user_profile.remote_user_id
  end

  def test_phone
    mock_for_method(:phone, "56225001 ext 289")
    assert_equal "56225001 ext 289", @user_profile.phone
  end

  def test_email
    mock_for_method(:email, 'alex@fisica.unam.mx')
    assert_equal 'alex@fisica.unam.mx', @user_profile.email
  end

  def test_user_incharge
    flexmock(UserProfileClient).should_receive(:user_incharge).and_return(@user_profile)
    mock_remote_user = UserProfileClient.find_by_user_id(167)
    flexmock(UserProfileClient).new_instances do |instance|
      instance.should_receive(:user_incharge).and_return(mock_remote_user)
    end
    assert_instance_of UserProfileClient, mock_remote_user.user_incharge
  end

  private

  def mock_for_method(method_name, returned_value) 
    flexmock(UserProfileClient).new_instances do |instance|
      instance.should_receive(method_name.to_sym).and_return(returned_value)
    end
  end
end
