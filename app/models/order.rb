class Order < ActiveRecord::Base
  validates_presence_of :date,  :order_status_id
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :user_id, :order_status_id, :greater_than => 0, :only_integer => true
  validates_numericality_of :user_incharge_id, :allow_nil => true, :greater_than => 0, :only_integer => true

  belongs_to :order_status
  has_many :order_products, :dependent => :destroy
  has_many :order_providers, :dependent => :destroy
  has_many :providers, :through => :order_providers
  has_one :order_file
  has_one :project
  has_one :currency_order

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

  def add_products(products)
    unless products.nil?
      if products.has_key? :new
        products[:new].each do |p|
          self.order_products << OrderProduct.new(p)
        end
      end
      if products.has_key? :existing
        products[:existing].each do |p|
          self.order_products << OrderProduct.update(p[0], p[1])
        end
      end
    end
  end

  def add_providers(providers)
    if providers.has_key? :new
      providers[:new].each do |p|
        provider = Provider.exists?(p) ? Provider.find(:first, :conditions => p) : Provider.new(p)
        self.providers << provider
      end
    end

    if providers.has_key? :existing
      providers[:existing].each do |p|
        Provider.update(p[0], p[1])
      end
    end
  end

  def add_files(files)
    if files.has_key? :new
      files[:new].each do |fh|
        self.order_file = OrderFile.new(:file => fh['file'].read, :content_type => fh['file'].content_type.chomp.to_s,
                                                              :filename => fh['file'].original_filename.chomp, :file_type_id => fh['file_type_id'])
      end
    end
    if files.has_key? :existing
      files[:existing].each do |p|
        fh = p[1]
        if fh['file'].nil?
          OrderFile.update(p[0], {:file_type_id => fh['file_type_id']})
        else
          OrderFile.update(p[0], {:file => fh['file'].read, :content_type => fh['file'].content_type.chomp.to_s,
                                                :filename => fh['file'].original_filename.chomp, :file_type_id => fh['file_type_id']})
        end
      end
    end
  end

  def add_projects(projects)
    if projects.has_key? :new
      projects[:new].each do |fh|
        self.project = Project.new(:name => fh['name'], :key => fh['key'],
                                                      :project_type_id => fh['project_type_id'])
      end
    end
    if projects.has_key? :existing
      projects[:existing].each do |p|
        fh = p[1]
        Project.update(p[0], {:name => fh['name'], :key => fh['key'],
                                           :project_type_id => fh['project_type_id']})
      end
    end
  end

  def add_currency_data(currency, currency_order)
    h = currency.attributes
    [:id, :user_id, :created_at, :updated_at, :moduser_id].each do |k|
      h.delete(k.to_s)
    end
    currency_order.currency = Currency.exists?(h) ? Currency.find(:first, :conditions => h) : currency
    self.currency_order = currency_order
  end

  def calculate_total_amount
    OrderProduct.sum("quantity * price_per_unit", :conditions => ['order_id=?', self.id])
  end

end
