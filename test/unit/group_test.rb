require File.dirname(__FILE__) + '/../test_helper'
require 'group'
class GroupTest < ActiveSupport::TestCase
  fixtures :groups

  should_validate_presence_of :name
  should_validate_uniqueness_of :name

  should_validate_numericality_of :id
  should_not_allow_zero_or_negative_number_for :id
end
