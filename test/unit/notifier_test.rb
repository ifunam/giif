require File.dirname(__FILE__) + '/../test_helper'
require 'notifier'
require 'mocha'
class NotifierTest < ActionMailer::TestCase

  def setup
    @user  = UserProfileClient.new
    @user.attributes = { 
                        'fullname' => "Fernando Reyes Jiménez", 'adscription_id' => 7,
                        'phone' => "56225001 ext 289", 'user_id' => 2, 'adscription' => "Apoyo",
                        'email' => "fereyji@someplace.com", 'user_incharge_id' =>167 
                        }
    
    @user_incharge = UserProfileClient.new
    @user_incharge.attributes = { 
                        'fullname' => "Juárez Robles Jesús Alejandro", 'adscription_id' => 7,
                        'phone' => "56225001 ext 289", 'user_id' => 167, 'adscription' => "Apoyo",
                        'email' => "alex@somewhere.com" 
                     }
  end

  test "should test order request sending from some user" do
    UserProfileClient.expects(:find_by_user_id).with(2).returns(@user)
    response = Notifier.create_order_request_from_user(Order.first, UserProfileClient.find_by_user_id(2))
    assert_equal '[GIIF] Solicitud de orden de compra enviada', response.subject
    assert_equal 'fereyji@someplace.com', response.to.first
  end
 
   test "Should notify to the user incharge" do
     UserProfileClient.expects(:find_by_user_id).with(167).returns(@user_incharge)
     response = Notifier.create_order_to_userincharge(Order.first, UserProfileClient.find_by_user_id(167))
     assert_equal '[GIIF] Solicitud de aprobación de orden de compra', response.subject
     assert_equal 'alex@somewhere.com', response.to.first
   end
 
   test "Should notify to about accepted request" do
     UserProfileClient.expects(:find_by_user_id).with(2).returns(@user)
     response = Notifier.create_request_approved(Order.first, UserProfileClient.find_by_user_id(2))
     assert_equal '[GIIF] Aprobación de solicitud interna de compra', response.subject
     assert_equal 'fereyji@someplace.com', response.to.first
   end
 
   test "Should notify to about rejected request" do
    UserProfileClient.expects(:find_by_user_id).with(2).returns(@user)
    response = Notifier.create_order_request_rejected(Order.first, UserProfileClient.find_by_user_id(2))
    assert_equal '[GIIF] Rechazo de solicitud interna de compra', response.subject
    assert_equal 'fereyji@someplace.com', response.to.first
   end
end
