require File.dirname(__FILE__) + '/../test_helper'

class UserAdscriptionTest < ActiveSupport::TestCase
  fixtures :user_adscriptions

  should_validate_presence_of :user_id, :adscription_id

  should_validate_numericality_of :user_id, :adscription_id

  should_belong_to :user, :adscription
end
