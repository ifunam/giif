require File.dirname(__FILE__) + '/../test_helper'
class OrderTest < ActiveSupport::TestCase
 fixtures :users, :order_statuses, :orders

  def setup
    @my_order = { :user_id => 2, :date => '2008-04-19', :administrative_key => 2, :order_status_id => 1}
  end

  def test_create
    @order = Order.new(@my_order)
    assert @order.valid?
    assert @order.save
    assert_equal 2, @order.user_id
    assert_equal 2008, @order.date.year
    assert_equal 4, @order.date.month
    assert_equal 19, @order.date.day
    assert_equal 2, @order.administrative_key
    assert_equal 1, @order.order_status_id
  end

   def test_not_create
    @order = Order.new(@my_order)
    @order.user_id = nil
    assert !@order.valid?
    assert !@order.save

     @order = Order.new(@my_order)
     @order.administrative_key = 1
     assert !@order.valid?
     assert !@order.save

       @order = Order.new(@my_order)
       @order.administrative_key  = nil
       assert !@order.valid?
       assert !@order.save

     @order = Order.new(@my_order)
     @order.date = nil
      assert !@order.valid?
      assert !@order.save

       @order = Order.new(@my_order)
       @order.order_status_id  = nil
       assert !@order.valid?
       assert !@order.save

       @order = Order.new(@my_order)
       @order.id  = -1
       assert !@order.valid?
       assert !@order.save

       @order = Order.new(@my_order)
       @order.id  = 'a'
       assert !@order.valid?
       assert !@order.save

       @order = Order.new(@my_order)
       @order.administrative_key  = -1
       assert !@order.valid?
       assert !@order.save

       @order = Order.new(@my_order)
       @order.administrative_key  = 'a'
       assert !@order.valid?
       assert !@order.save

       @order = Order.new(@my_order)
       @order.order_status_id  = -1
       assert !@order.valid?
       assert !@order.save

       @order = Order.new(@my_order)
       @order.order_status_id  = 'a'
       assert !@order.valid?
       assert !@order.save

       @order = Order.new(@my_order)
       @order.user_id  = -1
       assert !@order.valid?
       assert !@order.save

       @order = Order.new(@my_order)
       @order.user_id  = 'a'
       assert !@order.valid?
       assert !@order.save

       @order = Order.new(@my_order)
       @order.user_incharge_id  = -1
       assert !@order.valid?
       assert !@order.save

       @order = Order.new(@my_order)
       @order.user_incharge_id  = 'a'
       assert !@order.valid?
       assert !@order.save
   end

  def test_read
    @order = Order.find(1)
    assert @order.valid?
    assert @order.save
    assert_equal 1,@order.user_id
    assert_equal 2008, @order.date.year
    assert_equal 1, @order.date.month
    assert_equal 1, @order.date.day
    assert_equal 1,@order.administrative_key
    assert_equal 1,@order.order_status_id
   end

    def test_update
      @order = Order.find(1)
      @order.user_id = 56
      assert @order.save
      assert_equal 56, @order.user_id

      @order.date = '1984-08-07'
      assert @order.save
      assert_equal 1984, @order.date.year
      assert_equal 8, @order.date.month
      assert_equal 7, @order.date.day

      @order.administrative_key = 8966
      assert @order.save
      assert_equal 8966, @order.administrative_key

      @order.order_status_id = 7
      assert @order.save
      assert_equal 7, @order.order_status_id
    end

    def test_not_update_duplicated_administrative_key
      @order = Order.new(:user_id =>2, :date => '1983-10-10', :administrative_key => 1, :order_status_id => 3)
      assert !@order.valid?
      assert !@order.save
    end

    def test_not_update
      @order = Order.find(1)
      @order.administrative_key  = nil
      assert !@order.valid?
      assert !@order.save

      @order = Order.find(1)
      @order.date  = nil
      assert !@order.valid?
      assert !@order.save

      @order = Order.find(1)
      @order.order_status  = nil
      assert !@order.valid?
      assert !@order.save


      @order = Order.find(1)
      @order.id  = -1
      assert !@order.valid?
      assert !@order.save

      @order = Order.find(1)
      @order.id  = 'a'
      assert !@order.valid?
      assert !@order.save

      @order = Order.find(1)
      @order.administrative_key  = -1
      assert !@order.valid?
      assert !@order.save

      @order = Order.find(1)
      @order.administrative_key  = 'a'
      assert !@order.valid?
      assert !@order.save

      @order = Order.find(1)
      @order.order_status_id  = -1
      assert !@order.valid?
      assert !@order.save

      @order = Order.find(1)
      @order.order_status_id  = 'a'
      assert !@order.valid?
      assert !@order.save

      @order = Order.find(1)
      @order.user_id  = -1
      assert !@order.valid?
      assert !@order.save

      @order = Order.find(1)
      @order.user_id  = 'a'
      assert !@order.valid?
      assert !@order.save

      @order = Order.find(1)
      @order.user_incharge_id  = -1
      assert !@order.valid?
      assert !@order.save

      @order = Order.find(1)
      @order.user_incharge_id  = 'a'
      assert !@order.valid?
      assert !@order.save
    end

    def test_delete
      assert Order.destroy(1)
      assert_raise (ActiveRecord::RecordNotFound) {  Order.find(1)  }
    end

    def test_not_delete_nil
      assert_raise (ActiveRecord::RecordNotFound) {  Order.destroy(nil)  }
    end

    def test_status_name
      @record = Order.find(1)
      assert_equal 'En proceso',  @record.status_name
    end
end
