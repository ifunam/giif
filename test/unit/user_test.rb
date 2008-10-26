require File.dirname(__FILE__) + '/../test_helper'

class UserTest < ActiveSupport::TestCase
  fixtures :users, :addresses, :people, :adscriptions, :user_adscriptions

  should_require_attributes :login, :password, :email
  should_require_unique_attributes :login, :email

  should_belong_to :user_incharge
  should_have_one :person

  def setup
    @newuser = { :login => 'fernando', :email => 'usuario@mail.com', :password => 'lifeislife', :password_confirmation => 'lifeislife'}
  end

  def test_length_size_of_login
    @user = User.new(@newuser)
    @user.login = ' ' * 10
    assert !@user.valid?

    @user.login = 'login with white spaces'
    assert !@user.valid?

    @user.login = 'MyCapitalizeLogin'
    assert !@user.valid?

    @user.login = 'a' * 31
    assert !@user.valid?

    @user.login = 'lo'
    assert !@user.valid?
 end

  def test_length_size_of_password
    @user = User.new(@newuser)
    @user.password = '*' * 4
    assert !@user.valid?

    @user.password = '1' * 35
    assert !@user.valid?

    @user.password = 'password with spaces'
    assert !@user.valid?

    @user.password = 'Capitalize password'
    assert !@user.valid?

    @user.password = '@@@@@@@@@'
    assert !@user.valid?
  end

  def test_phone
    @record = User.find(2)
    assert_equal '26-21-20-44', @record.phone
  end

  def test_adscription_name
    @record = User.find(2)
    assert_equal 'Física Teórica', @record.adscription_name
  end

  def test_user_incharge_fullname
    @record = User.find(3)
    assert_equal 'Reyes Jímenez Fernando',@record.user_incharge_fullname
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
    @user.activate
    assert @user.is_activated?
    assert_equal User.encrypt('maltiempo', @user.salt), @user.password
  end

  def test_unactivate
    @user = User.find_by_login('fernando')
     assert @user.is_activated?
     @user.unactivate
     assert !@user.is_activated?
    assert_equal User.encrypt('maltiempo', @user.salt), @user.password
  end

  def test_verify_current_password
    @user = User.find(:first)
    @user.current_password = 'maltiempo'
    assert_equal nil, @user.send(:verify_current_password)
  end

    def test_verify_current_password_with_bad_password
    @user = User.find(:first)
    @user.current_password = 'inutil'
    assert !@user.send(:verify_current_password)
  end
end

