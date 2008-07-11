require File.dirname(__FILE__) + '/../test_helper'

class OrderProviderTest < ActiveSupport::TestCase
  fixtures :orders, :providers, :order_providers

  def setup
    @newOP = { :id => 4, :order_id => 4, :provider_id => 2 }
  end

  def test_create
    @order_provider = OrderProvider.new(@newOP)
    assert @order_provider.valid?
    assert @order_provider.save
    assert_equal 'HP México', @order_provider.provider.name
  end

  def test_not_create_if_order_id_is_zero
    @order_provider = OrderProvider.new(@newOP)
    @order_provider.order_id = 0
    assert !@order_provider.valid?
    assert !@order_provider.save
   end

  def test_not_create_if_provider_id_is_zero
    @order_provider = OrderProvider.new(@newOP)
    @order_provider.provider_id = 0
    assert !@order_provider.valid?
    assert !@order_provider.save
   end

  def test_not_create_if_order_id_is_lower_than_zero
    @order_provider = OrderProvider.new(@newOP)
    @order_provider.order_id = -1
    assert !@order_provider.valid?
    assert !@order_provider.save
   end

  def test_not_create_if_provider_id_is_lower_than_zero
    @order_provider = OrderProvider.new(@newOP)
    @order_provider.provider_id = -1
    assert !@order_provider.valid?
    assert !@order_provider.save
   end

  def test_not_create_if_order_id_is_not_integer
    @order_provider = OrderProvider.new(@newOP)
    @order_provider.order_id = 'string'
    assert !@order_provider.valid?
    assert !@order_provider.save
   end

  def test_not_create_if_provider_id_is_not_integer
    @order_provider = OrderProvider.new(@newOP)
    @order_provider.provider_id = 'string'
    assert !@order_provider.valid?
    assert !@order_provider.save
   end


  def test_read
    @order_provider = OrderProvider.find(2)
    assert @order_provider.valid?
    assert @order_provider.save
    assert_equal 2, @order_provider.order_id
    assert_equal 1, @order_provider.provider_id
    assert_equal 'Computación Génericos y Suministros',@order_provider.provider.name
   end

    def test_update
      @order_provider = OrderProvider.find(1)
      @order_provider.provider_id = 3
      assert @order_provider.save
      assert_equal 3, @order_provider.provider_id
    end

    def test_delete
      assert OrderProvider.destroy(1)
      assert_raise (ActiveRecord::RecordNotFound) {  OrderProvider.find(1)  }
    end

    def test_not_delete_nil
      assert_raise (ActiveRecord::RecordNotFound) {  OrderProvider.destroy(nil)  }
   end
end
