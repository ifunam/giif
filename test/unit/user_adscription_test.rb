require File.dirname(__FILE__) + '/../test_helper'

class UserAdscriptionTest < ActiveSupport::TestCase
  fixtures :user_adscriptions

  should_require_attributes :user_id, :adscription_id

  should_only_allow_numeric_values_for :user_id, :adscription_id

  should_belong_to :user, :adscription
end
