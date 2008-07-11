require File.dirname(__FILE__) + '/../test_helper'
class AdscriptionTest < ActiveSupport::TestCase
  fixtures :adscriptions

  should_require_attributes :name
  should_require_unique_attributes :name

  should_only_allow_numeric_values_for :id
  should_not_allow_zero_or_negative_number_for :id
  should_allow_nil_value_for :id
  should_not_allow_float_number_for :id

  should_have_many :user_adscriptions
end
