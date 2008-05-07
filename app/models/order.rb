class Order < ActiveRecord::Base

  validates_presence_of :date,  :order_status_id
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :user_id, :order_status_id, :greater_than => 0, :only_integer => true
  validates_numericality_of :user_incharge_id, :allow_nil => true, :greater_than => 0, :only_integer => true

  belongs_to :order_status
  has_many :order_products, :dependent => :destroy

  validates_associated :order_products, :order_status

  def status_name
    OrderStatus.find(self.order_status_id).name
  end

end
