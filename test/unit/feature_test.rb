 require File.dirname(__FILE__) + '/../test_helper'

class FeatureTest < ActiveSupport::TestCase
   fixtures :features

  def test_create
    @feature = Feature.new(:name =>'Windows XP')
    assert @feature.valid?
    assert @feature.save
    assert_equal 'Windows XP', @feature.name
  end

  def test_not_create
    @feature = Feature.new(:name =>nil)
    assert !@feature.valid?
    assert !@feature.save
    assert_equal nil, @feature.name
   end

  def test_read
    @feature = Feature.find(1)
    assert @feature.valid?
    assert @feature.save
    assert_equal 1,@feature.id
   end

    def test_update
      @feature = Feature.find_by_id(2)
      @feature.name = @feature.name.reverse
      assert @feature.save
      assert_equal 'Memoria'.reverse, @feature.name
    end

    def test_not_update_duplicated_name
      @feature = Feature.find(1)
      @feature.name = nil
      assert !@feature.valid?
    end

    def test_not_update
      @feature = Feature.find_by_id(1)
      @feature.name  = nil
      assert !@feature.valid?
      assert !@feature.save
    end

    def test_delete
      assert Feature.destroy(1)
      assert_raise (ActiveRecord::RecordNotFound) {  Feature.find(1)  }
    end

    def test_not_delete_nil
      assert_raise (ActiveRecord::RecordNotFound) {  Feature.destroy(nil)  }
   end
end
