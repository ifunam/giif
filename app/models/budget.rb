class Budget < ActiveRecord::Base
  validates_presence_of :order_id, :user_id, :previous_number, :code, :external_account
  belongs_to :order
end
