require File.dirname(__FILE__) + '/../test_helper'

class DocumentGeneratorTest < ActiveSupport::TestCase

  def setup
    @user_profile = UserProfileClient.new
    @user_profile.attributes = {
                                   'user_incharge_id' => 38,
                                   'adscription_id' => 7,
                                   'fullname' => "Juárez Robles Jesús Alejandro",
                                   'phone' => "56225001 ext 289",
                                   'adscription' => "Apoyo",
                                   'user_id' => 167,
                                   'email' =>"alex@fisica.unam.mx"}

    @order = Order.build_valid
    @order.order_status_id = 3

    products = { :new => [{:order_id => 2,  :quantity => 2, :description => 'Hub Koesre KIL-09', :price_per_unit => 1234.00}]}
    @order.add_products(products)

    providers = { :new => [{:name => 'Mac de México'}]}
    @order.add_providers(providers)

    file = mock('file')
    file.stubs(:original_filename).returns('Presupuesto_proyecto_CONACYT.pdf')
    file.stubs(:content_type).returns('application/pdf')
    file.stubs(:read).returns('file_content(a lot of bits here...)')
    file_1 = { :new => [{'file' => file, 'file_type_id' => 2}]}
     @order.add_files(file_1)

    project =     {:new => [{'name' => 'Mac de México', 'key' => '132-LPO', 'project_type_id' => 2}]}
    @order.add_projects(project)

    currency = Currency.new(:name => 'Pesos Marcianos', :url => 'someplace')
    currency_order = CurrencyOrder.new(:value => 10.5)
    @order.add_currency_data(currency, currency_order)
  end

  def test_should_generate_pdf
    @document = DocumentGenerator.new(@order, @user_profile)
    @document.to_pdf

    assert_not_nil @document
  end

  def test_should_generate_pdf_with_project_type_id_5
    @order.project.project_type_id = 5
    @document = DocumentGenerator.new(@order, @user_profile)
    @document.to_pdf

    assert_not_nil @document
  end
end
