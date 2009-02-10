class Budget < ActiveRecord::Base
  validates_presence_of :order_id, :user_id

  belongs_to :order
end
