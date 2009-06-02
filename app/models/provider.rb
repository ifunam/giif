require 'digest/sha2'
class Provider < ActiveRecord::Base
  validates_presence_of :name, :email

  def self.authenticate?(provider_id, order_id, token)
    if Provider.exists?(provider_id) and Order.exists?(order_id) 
      Provider.encrypt_token(provider_id, order_id, Provider.find(provider_id).created_at) == token
    else
      false
    end
  end

  def self.encrypt_token(provider_id, order_id, timestamp)
    Digest::SHA512.hexdigest([provider_id, order_id, timestamp.to_s].join('_')).slice(0..9) 
  end

end
