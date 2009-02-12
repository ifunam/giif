require File.dirname(__FILE__) + '/../test_helper'

class DirectAdjudicationTypeTest < ActiveSupport::TestCase
  should_require_attributes :name
  should_have_many :acquisitions
end
