class OrderLog < ActiveRecord::Base
  validates_presence_of :order_id, :user_id, :order_status_id

  belongs_to :order
end
