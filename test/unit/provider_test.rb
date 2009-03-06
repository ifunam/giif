require File.dirname(__FILE__) + '/../test_helper'

class ProviderTest < ActiveSupport::TestCase
  fixtures :providers

  should_validate_presence_of :name
  should_validate_uniqueness_of :name

  should_validate_numericality_of :id
end
