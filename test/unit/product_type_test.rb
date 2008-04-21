require File.dirname(__FILE__) + '/../test_helper'

class ProductTypeTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  fixtures :product_categories, :product_types
  def test_create
    @product_type = ProductType.new(:name => 'Computadoras', :product_category_id => 1)
    assert @product_type.valid?
    assert @product_type.save
    assert_equal  'Computadoras', @product_type.name
  end

  def test_not_create
    @product_type = ProductType.new(:name => nil)
    assert !@product_type.valid?
    assert !@product_type.save
    assert_equal nil, @product_type.name
   end

  def test_read
    @product_type = ProductType.find(1)
    assert @product_type.valid?
    assert @product_type.save
    assert_equal 1,@product_type.id
   end

    def test_update
      @product_type = ProductType.find(2)
      @product_type.name = @product_type.name.reverse
      assert @product_type.save
      assert_equal 'Servidor'.reverse, @product_type.name
    end

    def test_not_update_duplicated_name
      @product_type = ProductType.find(2)
      @product_type.name = "Modem"
      assert !@product_type.valid?
      assert !@product_type.save
    end

    def test_not_update
      @product_type = ProductType.find(1)
      @product_type.name  = nil
      assert !@product_type.valid?
      assert !@product_type.save
    end

    def test_delete
      assert ProductType.destroy(1)
      assert_raise (ActiveRecord::RecordNotFound) {  ProductType.find(1)  }
    end

    def test_not_delete_nil
      assert_raise (ActiveRecord::RecordNotFound) {  ProductType.destroy(nil)  }
   end
end
