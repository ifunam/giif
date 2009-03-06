require File.dirname(__FILE__) + '/../test_helper'

class ProjectTest < ActiveSupport::TestCase
  fixtures :projects

  should_validate_presence_of :project_type_id, :name, :key

  should_validate_numericality_of :id

  should_belong_to :order
end
