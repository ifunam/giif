# encoding: utf-8
require File.dirname(__FILE__) + '/../test_helper'
class UserProfileClientTest < ActiveSupport::TestCase
  remote_fixtures

  def setup
    @user_profile = UserProfileClient.find_by_login('alex')
  end

  def test_find_by_login
    assert_instance_of UserProfileClient, UserProfileClient.find_by_login('alex')
  end

  def test_find_by_user_id
    assert_instance_of UserProfileClient, UserProfileClient.find_by_user_id(1)
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
    assert_equal 1, @user_profile.remote_user_id
  end

  def test_phone
    assert_equal "56225001 ext 289", @user_profile.phone
  end

  def test_email
    assert_equal "alex@somewhere.com", @user_profile.email
  end

  def test_login
     assert_equal "alex", @user_profile.login
   end

  def test_user_incharge
    assert_instance_of UserProfileClient, @user_profile.user_incharge
  end
end
