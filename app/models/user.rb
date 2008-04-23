require 'digest/sha2'
class User < ActiveRecord::Base
  attr_accessor :current_password

  validates_presence_of :login, :password, :email
  validates_length_of :login, :within => 3..30
  validates_length_of :password, :within => 5..200, :allow_nil => true
  validates_confirmation_of :password
  validates_format_of :login, :with => /\A[-a-z0-9\.]*\Z/
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/
  validates_uniqueness_of :login, :email

  belongs_to :user_incharge, :class_name => "User", :foreign_key => "user_incharge_id"
  has_one :person
  # Callbacks
  before_create :prepare_new_record
  after_validation_on_create :encrypt_password # This callback is related to valid? and save methods, use one of them to make tests
  before_validation_on_update :verify_current_password

  class << self
      def authenticate?(l,pw)
        @user = User.find_by_login(l)
        (!@user.nil? and @user.password == encrypt(pw, @user.salt) and @user.is_activated?) ? true : false
      end

      def encrypt(password, mysalt)
        Digest::SHA512.hexdigest(password + mysalt)
      end
  end

    def phone
      record = Address.find(:first, :conditions => "user_id = #{self.id}")
      record.phone unless record.nil?
    end

  def adscription_name # TODO: Move this method to UserProfile Class
    record = UserAdscription.find(:first, :conditions => "user_id = #{self.id}")
    record.adscription.name unless record.nil?
  end

  def user_incharge_fullname
    self.user_incharge.person.fullname
  end
  def is_activated?
    self.status
  end

  def activate
    change_userstatus(true)
  end

  def unactivate
    change_userstatus(false)
  end

  protected
  def prepare_new_record
    self.status = false
  end

  def encrypt_password
    if self.password != nil
      self.salt = random_string(40)
      plaintext = password
      self.password = User.encrypt(plaintext, self.salt)
      self.password_confirmation = nil
    end
  end

  def verify_current_password
    if !self.current_password.nil?
      if User.find(:first, :conditions => ["id = ?", self.id]).password != User.encrypt(self.current_password, self.salt)
        errors.add("current_password", "is not valid")
        return false
      end
      encrypt_password
    end
  end

  def change_userstatus(st)
    self.status = st
    save(true)
  end

  def random_string(n)
    if n.to_i > 1
      s = ""
      char64 = (('a'..'z').collect + ('A'..'Z').collect + ('0'..'9').collect + ['.','/']).freeze
      n.times { s << char64[(Time.now.tv_usec * rand) % 64] }
      s
    end
  end
end
