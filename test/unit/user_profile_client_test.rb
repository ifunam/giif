require File.dirname(__FILE__) + '/../test_helper'
require 'rubygems'
require 'activeresource'
require 'flexmock/test_unit'
class UserProfileClientTest < Test::Unit::TestCase
  def setup
    @user_profile = UserProfileClient.new
    @user_profile.attributes = {
                                   'user_incharge_id' => 38,
                                   'adscription_id' => 7,
                                   'fullname' => "Juárez Robles Jesús Alejandro",
                                   'phone' => "56225001 ext 289",
                                   'adscription' => "Apoyo",
                                   'user_id' => 167,
                                   'email' =>"alex@fisica.unam.mx"}

  end

  def test_find_by_login
    flexmock(UserProfileClient).should_receive(:find_by_login).with('alex').and_return(@user_profile)
    # FIX IT: Complete testing for find_by_login method using instance of @attributes with mock object (Maybe)
    assert_instance_of UserProfileClient, UserProfileClient.find_by_login('alex')
  end

  def test_find_by_user_id
    flexmock(UserProfileClient).should_receive(:find_by_user_id).with(167).and_return(@user_profile)
    assert_instance_of UserProfileClient, UserProfileClient.find_by_user_id(167)
  end

  def test_fullname
    assert_equal "Juárez Robles Jesús Alejandro", @user_profile.fullname
  end

  def test_adscription_name
        assert_equal "Apoyo", @user_profile.adscription_name
  end

  def test_adscription_id
    assert_equal 7, @user_profile.adscription_id
  end

  def test_remote_user_id
    assert_equal 167, @user_profile.remote_user_id
  end

  def test_phone
    assert_equal "56225001 ext 289", @user_profile.phone
  end

  def test_email
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
end
