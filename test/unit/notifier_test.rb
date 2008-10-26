require File.dirname(__FILE__) + '/../test_helper'
require 'notifier'
require 'flexmock/test_unit'
class NotifierTest < ActionMailer::TestCase
  fixtures :users, :orders

  def setup
    @user_incharge = UserProfileClient.new
    @user_incharge.attributes = { 'fullname' => "Juárez Robles Jesús Alejandro", 'adscription_id' => 7,
                                  'phone' => "56225001 ext 289", 'user_id' => 167, 'adscription' => "Apoyo",
                                  'email' => "alex@fisica.unam.mx" }
    @user_profile = UserProfileClient.new
    @user_profile.attributes = { 'fullname' => "Fernando Reyes Jiménez", 'adscription_id' => 7,
                                 'phone' => "56225001 ext 289", 'user_id' => 2, 'adscription' => "Apoyo",
                                 'email' => "fereyji@gmail.com", 'user_incharge_id' =>167 }
  end

  def test_order_request_from_user
    flexmock(UserProfileClient).should_receive(:find_by_user_id).and_return(@user_profile)
    response = Notifier.create_order_request_from_user(Order.first, UserProfileClient.find_by_user_id(2))
    assert_equal '[GIIF] Solicitud de orden de compra', response.subject
    assert_equal 'fereyji@gmail.com', response.to.first
  end

  def test_order_to_userincharge
    flexmock(UserProfileClient).should_receive(:find_by_user_id).and_return(@user_incharge)
    response = Notifier.create_order_to_userincharge(Order.first, UserProfileClient.find_by_user_id(167))
    assert_equal '[GIIF] Solicitud de aprobación de orden de compra', response.subject
    assert_equal 'alex@fisica.unam.mx', response.to.first
  end
end
