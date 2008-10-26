require File.dirname(__FILE__) + '/../test_helper'

class ProviderTest < ActiveSupport::TestCase
  fixtures :providers

  should_require_attributes :name
  should_require_unique_attributes :name

  should_only_allow_numeric_values_for :id
end
