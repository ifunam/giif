class Order < ActiveRecord::Base

  validates_presence_of :date, :administrative_key, :order_status_id
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :user_id, :order_status_id, :administrative_key,  :greater_than => 0, :only_integer => true
  validates_numericality_of :user_incharge_id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_uniqueness_of :administrative_key

  belongs_to :order_status
  has_many :order_products, :dependent => :destroy

  def status_name
    OrderStatus.find(self.order_status_id).name
  end

end
