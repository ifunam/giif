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
    paginate(:conditions => [" orders.user_id = ? AND ( orders.order_status_id <= 2)", user_id ], 
             :page => page, :per_page => per_page)
  end

  def self.paginate_estimate_by_providers(user_id, page=1, per_page=20)
    paginate(:conditions => [" orders.user_id = ? AND ( orders.order_status_id >= 2)", user_id ], 
             :page => page, :per_page => per_page)
  end

  def self.paginate_by_orders(user_id, page=1, per_page=20)
    paginate(:conditions => [" orders.user_id = ? AND ( orders.order_status_id >= 3)", user_id ], 
             :page => page, :per_page => per_page)
  end

  def self.paginate_for_budget_backend(user_id, page=1, per_page=20)
    paginate(:conditions => [" orders.user_id = ? AND ( orders.order_status_id >= 4) AND (orders.order_status_id < 8)", user_id ], 
             :page => page, :per_page => per_page)
  end

  def self.paginate_for_acquisition_backend(user_id, page=1, per_page=20)
    paginate(:conditions => [" orders.user_id = ? AND ( orders.order_status_id >= 8)", user_id ], 
             :page => page, :per_page => per_page)
  end

  def verify_products_and_providers
    if self.send(:products).length <= 0
      errors.add_to_base("You should add at least one product")
    elsif self.send(:providers).length <= 0 
      errors.add_to_base("You should add at least one product")
    end
  end

  def current_status
    order_status.id == 2? (order_status.name + "\n" + self.estimates_received + " de "+ self.providers.size.to_s) : (order_status.name)
  end

  def sent
    change_status(4) if order_status_id == 3
  end

  def send_estimate_request
    change_status(2) if order_status_id == 1
  end

  def send_estimate_to_orders
    change_status(10) if order_status_id == 2
  end
  
  def change_to_unsent_order
    change_status(3) if order_status_id == 10
  end
  
  def approve
    change_status(7) if order_status_id == 4
  end

  def reject
    change_status(5) if order_status_id == 4
  end

  def total_price
    order_products.sum("quantity * price_per_unit").to_f
  end

  def estimates_received
    estimates = 0
    self.providers.each do |provider|
      estimates = estimates + 1 unless OrderFile.find_by_order_id_and_provider_id(self,provider).nil?
    end
    return estimates.to_s
  end

  private 
  def change_status(status_id)
    update_attributes(:order_status_id => status_id)
  end

end
