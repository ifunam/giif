class UserAdscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :adscription
end
