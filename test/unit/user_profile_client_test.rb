require File.dirname(__FILE__) + '/../test_helper'
require 'active_resource'
require 'active_resource/http_mock'

class UserProfileClientTest < Test::Unit::TestCase
  def setup
    @user = { 
      :user_id => 1,
      :fullname => "Juárez Robles Jesús Alejandro",
      :adscription => "Apoyo",
      :adscription_id => 7,
      :phone =>   "56225001 ext 289",
      :user_incharge_id  => 37,
      :email => 'alex@somewhere.com',
      :login => 'alex'
      }.to_xml(:root => :user)

    @user_incharge = { 
        :user_id => 37,
        :fullname => "López López Ramón",
        :adscription => "Física Teórica",
        :adscription_id => 1,
        :phone =>   "56225001 ext 289",
        :email => 'ramon@somewhere.com',
        :login => 'ramon'
        }.to_xml(:root => :user)
    ActiveResource::HttpMock.respond_to do |mock|
      mock.get "/academics/1.xml", {}, @user
      mock.get "/academics/show_by_login/alex.xml", {}, @user
      mock.get "/academics/37.xml", {}, @user_incharge
    end
    @user_profile = UserProfileClient.find(1)
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
