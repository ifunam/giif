class Order < ActiveRecord::Base
  validates_presence_of :date,  :order_status_id
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :user_id, :order_status_id, :greater_than => 0, :only_integer => true
  validates_numericality_of :user_incharge_id, :allow_nil => true, :greater_than => 0, :only_integer => true

  belongs_to :order_status
  has_many :order_products, :dependent => :destroy
  has_many :order_providers, :dependent => :destroy
  has_many :providers, :through => :order_providers
  has_many :order_files

  validates_associated :order_products, :order_status

  before_validation :verify_products_and_providers


  def verify_products_and_providers
    validation = true
    if self.order_products.size <= 0
      errors.add_to_base("You should add at least one product")
      validation = false
    elsif self.order_providers.size <= 0
      errors.add_to_base("You should add at least one provider")
      validation = false
    end
    validation
  end

  class << self
    def valid_options
      { :user_id=> 1,  :date=> '2008-01-01', :order_status_id=> 1}
    end

    def build_valid
      Order.new(Order.valid_options)
    end
  end


  def status_name
    OrderStatus.find(self.order_status_id).name
  end

  def add_products(products)
    unless products.nil?
      products.each do |p|
        self.order_products << OrderProduct.new(p)
      end
    end
  end

  def add_providers(providers)
#    unless providers.nil?
      providers.each do |p|
        provider = Provider.exists?(p) ? Provider.find(:first, :conditions => p) : Provider.new(p)
        order_provider = OrderProvider.new
        order_provider.provider = provider
        self.order_providers << order_provider
      end
 #   end
  end

#   def send_mail(order)
#     email = Notifier.create_sent(order)
#     email.set_content_type("text/html" )
#     Notifier.deliver(email)
#   end
end
