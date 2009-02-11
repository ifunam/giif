class Acquisition < ActiveRecord::Base
  validates_presence_of :order_id, :user_id, :direct_adjudication_type_id
  validates_inclusion_of :is_subcomittee_invitation, :is_subcomittee_bid, :in => [true,false]

  belongs_to :order
  belongs_to :direct_adjudication_type
end
