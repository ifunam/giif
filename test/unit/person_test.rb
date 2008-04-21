require File.dirname(__FILE__) + '/../test_helper'
class PersonTest < ActiveSupport::TestCase
  fixtures :users, :people

  def setup
    @person = { :user_id => 1,  :firstname => 'fulano', :lastname1 => 'sutano', :gender => true}
  end

  def test_fullname
    @record = Person.find(1)
    assert_equal 'Reyes Jiménez Fernando',  @record.fullname
  end

  def test_create
    @person = Person.new(@person)
    assert @person.valid?
    assert @person.save
    assert_equal 1, @person.user_id
    assert_equal 'fulano', @person.firstname
    assert_equal 'sutano', @person.lastname1
    assert_equal true, @person.gender
  end

   def test_not_create_if_first_name_nil
     @person = Person.new(@person)
     @person.firstname = nil
     assert !@person.valid?
     assert !@person.save
   end

   def test_not_create_if_lastname1_nil
     @person = Person.new(@person)
     @person.lastname1 = nil
     assert !@person.valid?
     assert !@person.save
   end

        #manejo de errores
       #  @person.valid?
       # puts @person.errors.full_messages.join(',')

   def test_not_create_if_id_is_lower_than_zero
     @person = Person.new(@person)
     @person.id = -1
     assert !@person.valid?
     assert !@person.save
   end

   def test_not_create_if_id_is_not_numeric
     @person = Person.new(@person)
     @person.id = 'a'
     assert !@person.valid?
     assert !@person.save
   end

   def test_not_create_if_user_id_is_not_numeric
     @person = Person.new(@person)
     @person.user_id = 'b'
     assert !@person.valid?
     assert !@person.save
   end

#    def test_not_create_if_gender_is_not_valid
#      @person = Person.new(@person)
#      @person.gender = 'verdadero'
#      assert !@person.valid?
#      assert !@person.save

#      puts @person.errors.full_messages.join(',')
#   end

  def test_read
    @person = Person.find(1)
    assert @person.valid?
    assert @person.save
    assert_equal 1,@person.id
   end

    def test_update
      @person = Person.find(1)
      @person.firstname = @person.firstname.reverse
      assert @person.save
      assert_equal 'Fernando'.reverse, @person.firstname
    end

    def test_not_update
      @person = Person.find(1)
      @person.firstname = nil
      assert !@person.valid?
      assert !@person.save

      @person = Person.find(1)
      @person.lastname1 = nil
      assert !@person.valid?
      assert !@person.save
    end

    def test_delete
      assert Person.destroy(1)
      assert_raise (ActiveRecord::RecordNotFound) {  Person.find(1)  }
    end

    def test_not_delete_nil
      assert_raise (ActiveRecord::RecordNotFound) {  Person.destroy(nil)  }
    end
 end
