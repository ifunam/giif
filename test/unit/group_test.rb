require File.dirname(__FILE__) + '/../test_helper'
require 'group'
class GroupTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  fixtures :groups
  def test_create
    @group = Group.new(:name => 'Las vacas locas')
    assert @group.valid?
    assert @group.save
    assert_equal 'Las vacas locas', @group.name
  end

  def test_create_bad_name
    @group = Group.new(:name => 'nil')
    #assert !@group.valid?
    #assert !@group.save
  end
#    def test_create
#     @group = Group.new(:name => new_group)
#    end
#    def test_read
#     @group = Group.find(index)
#    end
#    def test_update
#     @group = Group.update(:name = > new_name)
#    end
#    def test_delete
#      @group = Group.destroy(index)
#    end
end
