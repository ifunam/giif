require File.dirname(__FILE__) + '/../test_helper'

class DirectAdjudicationTypeTest < ActiveSupport::TestCase
  should_validate_presence_of :name
  should_have_many :acquisitions
end
