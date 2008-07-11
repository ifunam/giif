require File.dirname(__FILE__) + '/../test_helper'

class UserTest < ActiveSupport::TestCase
  fixtures :users, :addresses, :people, :adscriptions, :user_adscriptions

  def setup
    @newuser = { :login => 'fernando', :email => 'usuario@mail.com', :password => 'lifeislife', :password_confirmation => 'lifeislife'}
  end

  def test_phone
    @record = User.find(2)
    assert_equal '26-21-20-44', @record.phone
  end

  def test_user_incharge_fullname
    @record = User.find(3)
    assert_equal 'Reyes Jímenez Fernando',@record.user_incharge_fullname
  end

  def test_adscription_name
    @record = User.find(2)
    assert_equal 'Física Teórica', @record.adscription_name
  end

  def test_encrypt
    assert_equal '26a81243a061f05b38fec50ae303e6b018e6bdd0fa0891904b272e509103f4a7e9dfc68a13eea9114616bfdee045d83eed78123380a7f348633c543d3a46055b', User.encrypt('yoursecret', 'RhKfxHddtln1XPWw1bIwVefodA2p9MROequn/oEG,t')
  end

  def test_authenticate?
    assert User.authenticate?('admin', 'maltiempo')
    assert User.authenticate?('fernando', 'maltiempo')
  end

  def test_create_new_user
    @user = User.create({ :login => 'golem', :email => 'golem@example.com', :password => 'quire', :password_confirmation => 'quire' })
    assert_equal 'golem', @user.login
    assert_equal 'golem@example.com', @user.email
    assert_equal User.encrypt('quire', @user.salt), @user.password
    assert !@user.is_activated?
  end

  def test_activate
    @user = User.find_by_login('fernando')
    assert_equal 'fernando', @user.login
    assert_equal 'fereyji@gmail.com', @user.email
    assert_equal User.encrypt('maltiempo', @user.salt), @user.password
    assert @user.is_activated?
    assert @user.activate
    assert_equal User.encrypt('maltiempo', @user.salt), @user.password
  end

  def test_unactivate
    @user = User.find_by_login('fernando')
    assert @user.is_activated?
    assert @user.unactivate
    assert !@user.is_activated?
    assert_equal User.encrypt('maltiempo', @user.salt), @user.password
  end

  def test_invalid_login
     @user = User.new(@newuser)
     @user.login = nil
     assert !@user.valid?

     @user.login = ' ' * 10
     assert !@user.valid?

     @user.login = 'login with white spaces'
     assert !@user.valid?

     @user.login = 'MyLoginWithMayus'
     assert !@user.valid?

     @user.login = 'a' * 31
     assert !@user.valid?

     @user.login = 'lo'
     assert !@user.valid?
 end

  def test_invalid_password
      @user = User.new(@newuser)
      @user.password = nil
      assert !@user.valid?

      @user.password = '22'
      assert !@user.valid?

      @user.password = '1' * 400
      assert !@user.valid?
  end

  def test_uniqueness_for_login
      @user = User.new(@newuser)
      @user.login = 'fernando'
      assert !@user.valid?
  end

  def test_uniqueness_for_email
    @user = User.new(@newuser)
    @user.email = 'fereyji@gmail.com'
    assert !@user.valid?
  end

  def test_read_user
     @user = User.find(1)
     assert @user.valid?
     assert @user.save
     assert_equal 1, @user.id
  end

  def test_update_login
       @user = User.find(2)
       @user.login = @user.login.reverse
       assert @user.save
       assert_equal 'fernando'.reverse, @user.login
  end

  def test_update_email
       @user = User.find(2)
       @user.email = @user.email.reverse
       @user.save
       assert_equal 'fereyji@gmail.com'.reverse, @user.email
  end

  def test_not_update_with_bad_login
       @user = User.find(1)
       @user.login  = nil
       assert !@user.valid?

       @user.login  = '$$$#%&/()!$'
       assert !@user.valid?
  end

  def test_not_update_with_bad_password
       @user = User.find(1)
       @user.password  = nil
       assert !@user.valid?

       @user.login  = 'fe'
       assert !@user.valid?
  end

  def test_delete_user
       assert User.destroy(1)
       assert_raise (ActiveRecord::RecordNotFound) {  User.find(1)  }
  end

  def test_not_delete_nil
     assert_raise (ActiveRecord::RecordNotFound) {  User.destroy(nil)  }
  end
end

