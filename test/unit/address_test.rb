require File.dirname(__FILE__) + '/../test_helper'

class AddressTest < ActiveSupport::TestCase
   fixtures :addresses

  def setup
    @newaddress = { :user_id => 4, :location => 'Distrito Federal', :phone => '26-21-20-44' }
  end

  def test_create
    @address = Address.new(@newaddress)
    assert @address.valid?
    assert @address.save
    assert_equal 4, @address.user_id
    assert_equal 'Distrito Federal', @address.location
    assert_equal '26-21-20-44', @address.phone
  end

  def test_not_create_if_user_id_is_nil
    @address = Address.new(@newaddress)
    @address.user_id = nil
    assert !@address.valid?
    assert !@address.save
   end

  def test_not_create_if_location_is_nil
    @address = Address.new(@newaddress)
    @address.location = nil
    assert !@address.valid?
    assert !@address.save
  end

  def test_not_create_if_user_id_is_not_integer
    @address = Address.new(@newaddress)
    @address.user_id = 'not integer'
    assert !@address.valid?
    assert !@address.save
  end

  def test_not_create_if_id_is_not_integer
    @address = Address.new(@newaddress)
    @address.id = 'string'
    assert !@address.valid?
    assert !@address.save
  end

  def test_read
    @address = Address.find(1)
    assert @address.valid?
    assert @address.save
    assert_equal 1,@address.id
    assert_equal 'Distrito Federal',@address.location
   end

    def test_update
      @address = Address.find_by_id(1)
      @address.location = @address.location.reverse
      assert @address.save
      assert_equal 'Distrito Federal'.reverse, @address.location
    end

    def test_not_update_duplicated_user_id
      @address = Address.new(@newaddress)
      @address.user_id = 2
      assert !@address.valid?
    end

    def test_not_update
      @address = Address.find_by_id(1)
      @address.user_id  = nil
      assert !@address.valid?
      assert !@address.save
    end

    def test_delete
      assert Address.destroy(1)
      assert_raise (ActiveRecord::RecordNotFound) {  Address.find(1)  }
    end

    def test_not_delete_nil
      assert_raise (ActiveRecord::RecordNotFound) {  Address.destroy(nil)  }
   end
end
