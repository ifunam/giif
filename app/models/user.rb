class User < ActiveRecord::Base

  validates_presence_of :login, :password
  validates_uniqueness_of :login
  validates_length_of :login, :within => 3..30

  validates_length_of :password, :within => 5..200, :allow_nil => true
  validates_confirmation_of :password

  validates_format_of :login, :with => /\A[-a-z0-9\.]*\Z/

  class << self
      def authenticate?(login,password)
        !User.find(:first, :conditions =>['login = ? and password = ?', login,password]).nil?
      end
    end

end
