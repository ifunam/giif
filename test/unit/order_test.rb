require File.dirname(__FILE__) + '/../test_helper'
class OrderTest < ActiveSupport::TestCase
  fixtures :users, :order_statuses, :orders, :order_products, :providers, :order_providers

  def setup
    @my_order = { :user_id => 2, :date => '2008-04-19', :order_status_id => 1}
  end

  def test_create
    @order = Order.new(@myorder)
    assert_equal [], @order.providers
    assert !@order.valid?
  end

  def test_not_create
    @order = Order.new(@my_order)
    @order.user_id = nil
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
    assert_equal 1, @order.order_status_id
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

      @order.order_status_id = 7
      assert @order.save
      assert_equal 7, @order.order_status_id
    end

    def test_not_update
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

    def test_should_create_order
      @order = Order.build_valid
      @order.order_products << OrderProduct.build_valid
      @order.order_providers << OrderProvider.build_valid
      assert @order.valid?, @order.errors.full_messages
    end

    def test_should_not_create_order_with_empty_products
      @order = Order.build_valid
      @order.order_providers << OrderProvider.build_valid
      assert !@order.valid?, @order.errors.full_messages
    end

    def test_should_not_create_order_with_empty_providers
      @order = Order.build_valid
      @order.order_products << OrderProduct.build_valid
      assert !@order.valid?, @order.errors.full_messages
    end

    def test_should_add_products
      @order = Order.build_valid
      @order_products = { :new => [ {:quantity => 2,  :price_per_unit => 123.00, :description => 'Servidor marca X'},
                                     {:quantity => 3,  :price_per_unit => 145.70, :description => 'Routers marca Y'}
                                  ]
                         }
      @order.add_products(@order_products)
      assert_equal 2, @order.order_products.size
    end

    def test_should_not_add_products_with_empty_products
      @order = Order.build_valid
      @order.order_providers << OrderProvider.build_valid
      assert !@order.valid?
      assert_equal ["You should add at least one product"], @order.errors.full_messages
    end

    def test_should_add_providers
      @order = Order.build_valid
      @order_providers = { :new => [ { :name => 'Proveedor A'}, { :name => 'Proveedor B'} ] }
      @order.add_providers(@order_providers)
      assert_equal 2, @order.order_providers.size
    end

    def test_should_not_add_products_with_empty_providers
      @order = Order.build_valid
      @order.order_products << OrderProduct.build_valid
      assert !@order.valid?
      assert_equal ["You should add at least one provider"], @order.errors.full_messages
    end

end
