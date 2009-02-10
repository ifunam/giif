class Acquisition < ActiveRecord::Base
  validates_presence_of :order_id, :user_id, :currency_id, :direct_adjudication_type_id

  belongs_to :order
  belongs_to :direct_adjudication_type
end
