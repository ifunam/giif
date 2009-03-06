require File.dirname(__FILE__) + '/../test_helper'
class PersonTest < ActiveSupport::TestCase
  fixtures :users, :people

  should_validate_presence_of :lastname1, :firstname
  should_validate_uniqueness_of :user_id

  should_validate_numericality_of :id, :user_id
  should_belong_to :user

  def test_fullname
    @record = Person.find(1)
    assert_equal 'Reyes Jímenez Fernando',  @record.fullname
  end
 end
