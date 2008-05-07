require File.dirname(__FILE__) + '/../test_helper'

class OrderProductTest < ActiveSupport::TestCase
   fixtures :users, :order_statuses, :orders, :order_products

  def setup
    @neworderp = { :order_id => 4, :quantity => 2, :description => 'Notebook HP Pavilion MX-697', :price_per_unit => 8999.00 }
  end

  def test_create
    @orderp = OrderProduct.new(@neworderp)
    assert @orderp.valid?
    assert @orderp.save
    assert_equal 4, @orderp.order_id
    assert_equal 2, @orderp.quantity
    assert_equal 'Notebook HP Pavilion MX-697', @orderp.description
    assert_equal 8999.00, @orderp.price_per_unit
  end

  def test_not_create_if_quantity_is_nil
    @orderp = OrderProduct.new(@neworderp)
    @orderp.quantity = nil
    assert !@orderp.valid?
    assert !@orderp.save
   end

  def test_not_create_if_description_is_nil
    @orderp = OrderProduct.new(@neworderp)
    @orderp.description = nil
    assert !@orderp.valid?
    assert !@orderp.save
   end

  def test_not_create_if_priceperunit_is_nil
    @orderp = OrderProduct.new(@neworderp)
    @orderp.price_per_unit = nil
    assert !@orderp.valid?
    assert !@orderp.save
  end

  def test_not_create_if_quantity_is_not_integer
    @orderp = OrderProduct.new(@neworderp)
    @orderp.quantity = 'string'
    assert !@orderp.valid?
    assert !@orderp.save
  end

  def test_not_create_if_quantity_is_lower_or_equal_than_zero
    @orderp = OrderProduct.new(@neworderp)
    @orderp.quantity = 0
    assert !@orderp.valid?
    assert !@orderp.save

    @orderp.quantity = -2
    assert !@orderp.valid?
    assert !@orderp.save
  end

  def test_not_create_if_priceperunit_is_not_integer
    @orderp = OrderProduct.new(@neworderp)
    @orderp.price_per_unit = 'string'
    assert !@orderp.valid?
    assert !@orderp.save
  end

  def test_not_create_if_priceperunit_is_lower_or_equal_than_zero
    @orderp = OrderProduct.new(@neworderp)
    @orderp.price_per_unit = 0
    assert !@orderp.valid?
    assert !@orderp.save

    @orderp.price_per_unit = -2
    assert !@orderp.valid?
    assert !@orderp.save
  end

  def test_read
    @orderp = OrderProduct.find(1)
    assert @orderp.valid?
    assert @orderp.save
    assert_equal 1, @orderp.id
    assert_equal 10, @orderp.quantity
    assert_equal 5667.00, @orderp.price_per_unit
    assert_equal 'UPS Triplite 500W', @orderp.description
   end

    def test_update
      @orderp = OrderProduct.find_by_id(1)
      @orderp.description = @orderp.description.reverse
      assert @orderp.save
      assert_equal 'UPS Triplite 500W'.reverse, @orderp.description
    end

    def test_not_update
      @orderp = OrderProduct.find_by_id(1)
      @orderp.description  = nil
      assert !@orderp.valid?
      assert !@orderp.save
    end

    def test_delete
      assert OrderProduct.destroy(1)
      assert_raise (ActiveRecord::RecordNotFound) {  OrderProduct.find(1)  }
    end

    def test_not_delete_nil
      assert_raise (ActiveRecord::RecordNotFound) {  OrderProduct.destroy(nil)  }
   end
end
