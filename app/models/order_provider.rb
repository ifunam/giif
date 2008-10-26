class OrderProvider < ActiveRecord::Base
  validates_presence_of :order_id, :provider_id
  validates_numericality_of :order_id, :provider_id,  :only_integer => true, :greater_than => 0, :allow_nil => true

  belongs_to :order
  belongs_to :provider

# validates_associated :order, :provider, :on => :update
end
