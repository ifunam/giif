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
  has_many :projects
  has_one :currency_order

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
        self.order_files << OrderFile.new(:file => fh['file'].read, :content_type => fh['file'].content_type.chomp.to_s,
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
        self.projects << Project.new(:name => fh['name'], :key => fh['key'],
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

  def add_currency_data(id, name, url, value)
    @currency = Currency.new
    @currency_order = CurrencyOrder.new

    if Currency.find_by_name(name).nil?
      @currency.name = name
      @currency.url = url
      @currency.save
    end

    @currency_order.currency_id = id
    @currency_order.order_id = self.id
    @currency_order.value = value
  end

end
