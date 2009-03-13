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
  before_save :read_files
  
  def read_files
    files.each do |file|
      if file.is_a? Hash
        file['content_type'] = file['file'].content_type
        file['filename'] =  file['file'].original_filename
        file['file'] = file['file'].read
      end
    end
  end

  def verify_products_and_providers
    validation = true
    if order_products.size <= 0
      errors.add_to_base("You should add at least one product")
      validation = false
    elsif providers.size <= 0
      errors.add_to_base("You should add at least one provider")
      validation = false
    end
    validation
  end

  def current_status
    order_status.name
  end

  def sent
    change_status(2) if order_status_id == 1
  end

  def approve
    change_status(3) if order_status_id == 2
  end

  def reject
    change_status(4) if order_status_id == 2
  end

  def total_amount
    order_products.sum("quantity * price_per_unit").to_f
  end

  private 
  def change_status(status_id)
    update_attributes(:order_status_id => status_id)
  end
end
