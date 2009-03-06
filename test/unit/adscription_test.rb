require File.dirname(__FILE__) + '/../test_helper'
class AdscriptionTest < ActiveSupport::TestCase
  fixtures :adscriptions

  should_validate_presence_of :name
  should_validate_uniqueness_of :name

  should_validate_numericality_of :id
  should_not_allow_zero_or_negative_number_for :id
  should_allow_nil_value_for :id
  should_not_allow_float_number_for :id

  should_have_many :user_adscriptions
end
