class UserAdscription < ActiveRecord::Base
  validates_presence_of :user_id, :adscription_id
  validates_numericality_of :user_id, :adscription_id, :greater_than => 0, :only_integer => true

  belongs_to :user
  belongs_to :adscription
end
