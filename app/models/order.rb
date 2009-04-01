class Order < ActiveRecord::Base
  
  validates_presence_of :date
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

  # After initialize callbacks
  # after_initialize :build_file
  # after_initialize :build_project
  # after_initialize :build_products
  # after_initialize :build_providers
 
  before_validation :verify_products_and_providers
  # Fix It: Move this method to OrderFile class if the accepts_nested_attributes_for method is improved
  before_save :read_file
  
  default_scope :order => "orders.date ASC"
  
  def initialize(*args)
    super
    if args.size > 0
      products.build unless args.first[:products_attributes]
      providers.build unless args.first[:providers_attributes]
    else
      providers.build
      products.build
    end 
  end
  
  def self.paginate_by_user_id(user_id, page=1, per_page=20)
    paginate(:conditions => { :user_id =>  user_id }, :page => page, :per_page => per_page)
  end

  def self.paginate_unsent_by_user_id(user_id, page=1, per_page=20)
    paginate(:conditions => [" orders.user_id = ? AND ( orders.order_status_id = 1 OR orders.order_status_id = 5 )", user_id ], 
             :page => page, :per_page => per_page)
  end

  def build_file_and_project
      build_file
      build_project
  end

  def read_file
     if file.class == OrderFile and !file.file.nil? and !file.file.is_a? String
      file.content_type = file.file.content_type
      file.filename = file.file.original_filename
      file.file = file.file.read
    end
  end

  def verify_products_and_providers
    if self.send(:products).length <= 0
      errors.add_to_base("You should add at least one product")
    elsif self.send(:providers).length <= 0 
      errors.add_to_base("You should add at least one product")
    end
  end

  def current_status
    order_status.name
  end

  def sent
    change_status(2) if order_status_id == 1
  end

  def send_estimate_request
    change_status(5) if order_status_id == 1
  end

  def approve
    change_status(3) if order_status_id == 2
  end

  def reject
    change_status(4) if order_status_id == 2
  end

  def form_filled
    change_status(7) if order_status_id == 2
  end
 
  def total_price
    order_products.sum("quantity * price_per_unit").to_f
  end

#  private 
  def change_status(status_id)
    update_attributes(:order_status_id => status_id)
  end
end
