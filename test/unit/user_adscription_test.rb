require File.dirname(__FILE__) + '/../test_helper'

class UserAdscriptionTest < ActiveSupport::TestCase
  fixtures :user_adscriptions
  def test_create
    @useradscription = UserAdscription.new(:user_id => 3, :adscription_id => 1)
    assert @useradscription.valid?
    assert @useradscription.save
    assert_equal 3, @useradscription.user_id
    assert_equal 1, @useradscription.adscription_id
  end

  def test_not_create_if_user_id_is_nil
    @useradscription = UserAdscription.new(:user_id => nil, :adscription_id => 1)
    assert !@useradscription.valid?
    assert !@useradscription.save
   end

  def test_not_create_if_adscription_id_is_nil
    @useradscription = UserAdscription.new(:user_id => 3, :adscription_id => nil)
    assert !@useradscription.valid?
    assert !@useradscription.save
   end

  def test_not_create_if_user_id_is_not_integer
    @useradscription = UserAdscription.new(:user_id => 'string', :adscription_id => 1)
    assert !@useradscription.valid?
    assert !@useradscription.save
   end

  def test_not_create_if_user_id_is_lower_than_zero
    @useradscription = UserAdscription.new(:user_id => -2, :adscription_id => 1)
    assert !@useradscription.valid?
    assert !@useradscription.save
   end

  def test_not_create_if_adscription_id_is_not_integer
    @useradscription = UserAdscription.new(:user_id => 3, :adscription_id => 'string')
    assert !@useradscription.valid?
    assert !@useradscription.save
   end

  def test_not_create_if_adscription_id_is_lower_than_zero
    @useradscription = UserAdscription.new(:user_id => 3, :adscription_id => -4)
    assert !@useradscription.valid?
    assert !@useradscription.save
   end

  def test_read
    @useradscription = UserAdscription.find(1)
    assert @useradscription.valid?
    assert @useradscription.save
    assert_equal 1,@useradscription.adscription_id
    assert_equal 2,@useradscription.user_id
   end

    def test_update
      @useradscription = UserAdscription.find(1)
      @useradscription.user_id = 2
      assert @useradscription.save
      assert_equal 2, @useradscription.user_id
    end

    def test_not_update
      @useradscription = UserAdscription.find(1)
      @useradscription.user_id  = nil
      assert !@useradscription.valid?
      assert !@useradscription.save
    end

    def test_delete
      assert UserAdscription.destroy(1)
      assert_raise (ActiveRecord::RecordNotFound) {  UserAdscription.find(1)  }
    end

    def test_not_delete_nil
      assert_raise (ActiveRecord::RecordNotFound) {  UserAdscription.destroy(nil)  }
    end
end
