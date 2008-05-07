require File.dirname(__FILE__) + '/../test_helper'

class OrderStatusTest < ActiveSupport::TestCase
  fixtures :order_statuses

  def test_create
    @orderstatus= OrderStatus.new(:name => 'Otro')
    assert @orderstatus.valid?
    assert @orderstatus.save
    assert_equal 'Otro', @orderstatus.name
  end

  def test_not_create
    @orderstatus = OrderStatus.new(:name => nil)
    assert !@orderstatus.valid?
    assert !@orderstatus.save
   end

  def test_read
    @orderstatus = OrderStatus.find(1)
    assert @orderstatus.valid?
    assert @orderstatus.save
    assert_equal 'En proceso',@orderstatus.name
   end

    def test_update
      @orderstatus = OrderStatus.find(2)
      @orderstatus.name = @orderstatus.name.reverse
      assert @orderstatus.save
      assert_equal 'Alta'.reverse, @orderstatus.name
    end

    def test_not_update_duplicated_name
      @orderstatus = OrderStatus.find(1)
      @orderstatus.name = 'Alta'
      assert !@orderstatus.valid?
      assert !@orderstatus.save
    end

    def test_not_update
      @orderstatus = OrderStatus.find(1)
      @orderstatus.name  = nil
      assert !@orderstatus.valid?
      assert !@orderstatus.save
    end

    def test_delete
      assert OrderStatus.destroy(1)
      assert_raise (ActiveRecord::RecordNotFound) {  OrderStatus.find(1)  }
    end

    def test_not_delete_nil
      assert_raise (ActiveRecord::RecordNotFound) {  OrderStatus.destroy(nil)  }
   end
end
