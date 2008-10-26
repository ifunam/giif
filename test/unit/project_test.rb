require File.dirname(__FILE__) + '/../test_helper'

class ProjectTest < ActiveSupport::TestCase
  fixtures :projects

  should_require_attributes :project_type_id, :name, :key

  should_only_allow_numeric_values_for :id

  should_belong_to :order
end
