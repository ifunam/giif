require 'rubygems'
require 'activeresource'
class UserProfileClient < ActiveResource::Base
  self.site = 'http://salva.fisica.unam.mx/'
  self.element_name = "academic"
  
  def self.find_by_login(login)
    @attributes = self.get("show_by_login/#{login}")
    self.find(@attributes['user_id'])
  end
  
  def self.find_by_user_id(id)
     self.find(id)
  end

  def fullname
    @attributes['fullname']
  end
  
  def adscription_name
    @attributes['adscription']
  end

  def adscription_id
    @attributes['adscription_id']
  end

  def remote_user_id
    @attributes['user_id']
  end
end