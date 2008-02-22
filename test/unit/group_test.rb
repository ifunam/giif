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

  def test_not_create
    @group = Group.new(:name => nil)
    assert !@group.valid?
    assert !@group.save
    assert_equal nil, @group.name
   end

  def test_read
    @group = Group.find(1)
    assert @group.valid?
    assert @group.save
    assert_equal 1,@group.id
   end

    def test_update
      @group = Group.find(2)
      @group.name = @group.name.reverse
      assert @group.save
      assert_equal 'Administrador'.reverse, @group.name
    end

    def test_not_update_duplicated_name
      @group = Group.find(2)
      @group.name = "Default"
      assert !@group.valid?
    end

    def test_not_update
      @group = Group.find(1)
      @group.name  = nil
      assert !@group.valid?
      assert !@group.save
    end

    def test_delete
      assert Group.destroy(1)
      assert_raise (ActiveRecord::RecordNotFound) {  Group.find(1)  }
    end

    def test_not_delete_nil
      assert_raise (ActiveRecord::RecordNotFound) {  Group.destroy(nil)  }
    end
end
