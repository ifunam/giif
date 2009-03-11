class Order < ActiveRecord::Base
  validates_presence_of :date,  :order_status_id
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :user_id, :order_status_id, :greater_than => 0, :only_integer => true
  validates_numericality_of :user_incharge_id, :allow_nil => true, :greater_than => 0, :only_integer => true

  belongs_to :order_status
  belongs_to :user
  
  has_many :order_products, :dependent => :destroy
  has_many :products, :class_name => 'OrderProduct'
  accepts_nested_attributes_for :products
  
  has_many :order_providers, :dependent => :destroy
  has_many :providers, :through => :order_providers
  accepts_nested_attributes_for :providers
 
  has_one :order_file
  has_one :file, :class_name => 'OrderFile'
  accepts_nested_attributes_for :file

  has_many :order_files, :dependent => :destroy
  has_many :files, :class_name => 'OrderFile'
  accepts_nested_attributes_for :files

  has_one :project, :dependent => :destroy
  accepts_nested_attributes_for :project

  has_many :projects, :dependent => :destroy
  accepts_nested_attributes_for :projects
    
  has_one :currency_order
  accepts_nested_attributes_for :currency_order

  has_one :currency, :through => :currency_order
  accepts_nested_attributes_for :currency

  has_one :budget
  has_one :acquisition


  validates_associated :order_products, :order_status

  before_validation :verify_products_and_providers


  def verify_products_and_providers
    validation = true
    if self.order_products.size <= 0
      errors.add_to_base("You should add at least one product")
      validation = false
    elsif self.providers.size <= 0
      errors.add_to_base("You should add at least one provider")
      validation = false
    end
    validation
  end

  def status_name
    OrderStatus.find(self.order_status_id).name
  end

  def change_to_sent_status
    if self.order_status_id ==1
      self.order_status_id = 2
      self.save
    end
  end

  def change_to_approved_status
   if self.order_status_id ==2
      self.order_status_id = 3
      self.save
   end
  end

  def change_to_rejected_status
   if self.order_status_id ==2
      self.order_status_id = 4
      self.save
   end
  end

  def total_amount
    order_products.sum("quantity * price_per_unit").to_f
  end
end
