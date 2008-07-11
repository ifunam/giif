require File.dirname(__FILE__) + '/../test_helper'

class ProviderTest < ActiveSupport::TestCase
  fixtures :providers

  def test_create
    @provider = Provider.new(:name => 'HP Company Mexico')
    assert @provider.valid?
    assert @provider.save
    assert_equal 'HP Company Mexico', @provider.name
  end

  def test_not_create_if_name_is_nil
   @provider = Provider.new(:name => nil)
    assert !@provider.valid?
    assert !@provider.save
    assert_equal nil, @provider.name
   end

  def test_not_create_if_id_is_zero
   @provider = Provider.new(:id => 0)
    assert !@provider.valid?
    assert !@provider.save
   end

  def test_not_create_if_id_is_lower_than_zero
   @provider = Provider.new(:id => -2)
    assert !@provider.valid?
    assert !@provider.save
   end

  def test_not_create_if_id_is_not_integer
   @provider = Provider.new(:id => 'string')
    assert !@provider.valid?
    assert !@provider.save
   end


  def test_read
    @provider = Provider.find(5)
    assert @provider.valid?
    assert @provider.save
    assert_equal 'Tonermex S.A. de C.V.',@provider.name
   end

    def test_update
      @provider = Provider.find(4)
      @provider.name = @provider.name.reverse
      assert @provider.save
      assert_equal 'Grupo Salinas'.reverse, @provider.name
    end

    def test_not_update
      @provider = Provider.find_by_id(1)
      @provider.name  = nil
      assert !@provider.valid?
      assert !@provider.save
    end

    def test_not_update_duplicated_name
      @provider = Provider.find(2)
      @provider.name = 'Grupo Salinas'
      assert !@provider.valid?
      assert !@provider.save
    end

    def test_delete
      assert Provider.destroy(1)
      assert_raise (ActiveRecord::RecordNotFound) {  Provider.find(1)  }
    end

    def test_not_delete_nil
      assert_raise (ActiveRecord::RecordNotFound) {  Provider.destroy(nil)  }
   end
end
