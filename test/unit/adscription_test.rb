require File.dirname(__FILE__) + '/../test_helper'

class AdscriptionTest < ActiveSupport::TestCase
  fixtures :adscriptions

  def test_create
    @adscription = Adscription.new(:name => 'Desarrollo de software')
    assert @adscription.valid?
    assert @adscription.save
    assert_equal 'Desarrollo de software', @adscription.name
  end

  def test_not_create_if_name_is_nil
   @adscription = Adscription.new(:name => nil)
    assert !@adscription.valid?
    assert !@adscription.save
    assert_equal nil, @adscription.name
   end

  def test_not_create_if_id_is_zero
   @adscription = Adscription.new(:id => 0)
    assert !@adscription.valid?
    assert !@adscription.save
   end

  def test_not_create_if_id_is_lower_than_zero
   @adscription = Adscription.new(:id => -2)
    assert !@adscription.valid?
    assert !@adscription.save
   end

  def test_not_create_if_id_is_not_integer
   @adscription = Adscription.new(:id => 'string')
    assert !@adscription.valid?
    assert !@adscription.save
   end


  def test_read
    @adscription = Adscription.find(5)
    assert @adscription.valid?
    assert @adscription.save
    assert_equal 'Materia Condensada',@adscription.name
   end

    def test_update
      @adscription = Adscription.find(3)
      @adscription.name = @adscription.name.reverse
      assert @adscription.save
      assert_equal 'Sistemas Complejos'.reverse, @adscription.name
    end

    def test_not_update
      @adscription = Adscription.find_by_id(1)
      @adscription.name  = nil
      assert !@adscription.valid?
      assert !@adscription.save
    end

    def test_not_update_duplicated_name
      @adscription = Adscription.find(7)
      @adscription.name = 'Materia Condensada'
      assert !@adscription.valid?
      assert !@adscription.save
    end

    def test_delete
      assert Adscription.destroy(1)
      assert_raise (ActiveRecord::RecordNotFound) {  Adscription.find(1)  }
    end

    def test_not_delete_nil
      assert_raise (ActiveRecord::RecordNotFound) {  Adscription.destroy(nil)  }
   end
end
