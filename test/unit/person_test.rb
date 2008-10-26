require File.dirname(__FILE__) + '/../test_helper'
class PersonTest < ActiveSupport::TestCase
  fixtures :users, :people

  should_require_attributes :lastname1, :firstname
  should_require_unique_attributes :user_id

  should_only_allow_numeric_values_for :id, :user_id
  should_belong_to :user

  def test_fullname
    @record = Person.find(1)
    assert_equal 'Reyes Jímenez Fernando',  @record.fullname
  end
 end
