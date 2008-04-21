require File.dirname(__FILE__) + '/../test_helper'

class RoomTypeTest < ActiveSupport::TestCase
  fixtures :room_types

  def test_create
    @room_type = RoomType.new(:name => 'Aula')
    assert @room_type.valid?
    assert @room_type.save
    assert_equal 'Aula', @room_type.name
  end

  def test_not_create
   @room_type = RoomType.new(:name => nil)
    assert !@room_type.valid?
    assert !@room_type.save
    assert_equal nil, @room_type.name
   end

  def test_read
    @room_type = RoomType.find(4)
    assert @room_type.valid?
    assert @room_type.save
    assert_equal 'Otro',@room_type.name
   end

    def test_update
      @room_type = RoomType.find(3)
      @room_type.name = @room_type.name.reverse
      assert @room_type.save
      assert_equal 'Laboratorio'.reverse, @room_type.name
    end

    def test_not_update_duplicated_name
      @room_type = RoomType.find(2)
      @room_type.name = 'Laboratorio'
      assert !@room_type.valid?
      assert !@room_type.save
    end

    def test_not_update
      @room_type = RoomType.find_by_id(1)
      @room_type.name  = nil
      assert !@room_type.valid?
      assert !@room_type.save
    end

    def test_delete
      assert RoomType.destroy(1)
      assert_raise (ActiveRecord::RecordNotFound) {  RoomType.find(1)  }
    end

    def test_not_delete_nil
      assert_raise (ActiveRecord::RecordNotFound) {  RoomType.destroy(nil)  }
   end
end
