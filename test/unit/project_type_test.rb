require File.dirname(__FILE__) + '/../test_helper'

class ProjectTypeTest < ActiveSupport::TestCase
 fixtures :project_types

  should_require_attributes :name
  should_require_unique_attributes :name

  should_only_allow_numeric_values_for :id
  should_not_allow_zero_or_negative_number_for :id
end
