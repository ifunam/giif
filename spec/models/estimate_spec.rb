require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Estimate" do

  before(:each) do
    @products = [ { :quantity => 2, :description => 'Hub Koesre KIL-09',:product_category_id => 1 },
                  { :quantity => 10, :description => 'Macbook Air', :product_category_id => 2 }
                 ]
    @providers = [ { :name => 'Apple Store', :email => 'sales@apple.com' }, 
                   { :name => 'Dell MX', :email => 'sales@dell.com.mx'} 
                 ]
    @valid_attributes = {
      :user_id => 1,
      :date => Date.today,
      :ip_address => '127.0.0.1',
    }
  end

  it "should create a new instance given valid attributes" do
    @record = Order.create!(@valid_attributes.merge(:products_attributes => @products, :providers_attributes => @providers))
    @record.current_status.should == 'Sin enviar'
  end
  
  it "should create a valid instance given valid attributes" do
    @record = Order.new(@valid_attributes) # Old style should work too
    @products.each do |h| @record.products.build(h)  end
    @providers.each do |h| @record.providers.build(h) end
    @record.valid?
    @record.save
  end
  
  it "should not create a new instance because at least a product is missing" do
     @record = Order.new(@valid_attributes.merge(:providers_attributes => @providers))
     @record.should_not be_valid
  end
  
  it "should not create a new instance because at least a providers is missing" do
     @record = Order.new(@valid_attributes.merge(:products_attributes => @products))
     @record.should_not be_valid
  end
end
