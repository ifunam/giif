# encoding: utf-8

require File.dirname(__FILE__) + '/../../test_helper'
require 'action_view/test_case'

# class ApplicationHelperViewTest < ActionView::TestCase
#   fixtures :users, :order_statuses, :orders, :product_categories, :order_products, :unit_types,
#   :providers, :order_providers, :currencies, :currency_orders, :order_files
# 
#   include ApplicationHelper
#   include ActionView::Helpers
# 
#   def setup
#     @view = ActionView::Base.new("#{RAILS_ROOT}/app/views/files")
#   end
# 
#   test "should return javascript function for file_form" do
#     @order = Order.find(8)
#     @request = ActionController::TestRequest.new
#     @controller = OrdersController.new
#    assert_nil content_for_file_form_head # FIX IT: It depends or rendering
#   end
# end

class ApplicationHelperTest < ActionController::TestCase
  fixtures :users, :order_statuses, :orders, :product_categories, :order_products, :unit_types,
  :providers, :order_providers, :currencies, :currency_orders, :order_files
  #, :order_products

  include ApplicationHelper
  include ActionView::Helpers

  def setup
    @request = ActionController::TestRequest.new
    @controller = OrdersController.new
    @view = ActionView::Base.new("#{RAILS_ROOT}/app/views/files")
  end

  test "should return the login of a logged user" do
    session_as('alex')
    assert_equal "alex", logged_user
  end

  test "should return the login of a logged provider" do
    provider_session_as('HP México')
    assert_equal "HP México", logged_provider
  end

  test "should render a simple select html list" do
    assert_dom_equal %Q(<select name=\"form[order_status_id]\" id=\"form_order_status_id\"><option value=\"\">--Seleccionar--</option>\n<option value=\"8\">Adquisición en proceso</option>\n<option value=\"9\">Adquisición realizada</option>\n<option value=\"7\">Aprobado</option>\n<option value=\"2\">Cotización en proceso</option>\n<option value=\"1\">Cotización no enviada</option>\n<option value=\"4\">Presupuesto en progreso</option>\n<option value=\"5\">Rechazado</option>\n<option value=\"3\">Solicitud no enviada</option>\n<option value=\"10\">Solicitud sin cotización</option>\n<option value=\"6\">Transferencia</option></select>), simple_select(:form, OrderStatus)
  end

  test "should return a numerate list of providers" do
    assert_dom_equal %Q(<ol><li>Computación Génericos y Suministros</li></ol>), numerate_list(Order.find(2).providers, :name)
  end

  test "should return a list of products" do
    assert_dom_equal %Q(<ol><li>UPS Triplite 500W --10 caja(s)--</li></ol>), list_products(Order.find(2).products)
  end

  test "should return a list of providers" do
    assert_dom_equal %Q(<ol><li>Computación Génericos y Suministros  (genericos@hotmail.com)</li></ol>), list_providers(Order.find(2).providers)
  end

  test "should return link_to some action" do
    assert_dom_equal %Q(<a href=\"send\"><img title=\"Enviar\" src=\"/images/icon_send.png\" alt=\"Icon_send\" /></a><a href=\"send\">Enviar</a>), link_to_action("Enviar", "icon_send.png", "send")    
  end

  test "should render a simple select html using ActiveRecord find options" do
    assert_dom_equal %Q(<select name=\"form[currency_id]\" id=\"form_currency_id\"><option value=\"\">--Seleccionar--</option>\n<option value=\"3\">Dólar Américano</option>\n<option value=\"2\">Euro</option>\n<option value=\"5\">Libra esterlina</option>\n<option value=\"6\">Otro</option>\n<option value=\"1\">Peso</option>\n<option value=\"4\">Yen</option></select>), simple_select(:form, Currency, :conditions => "id <= 6")
  end

  test "should return index for new file" do
    assert_equal 3, index_file_form(OrderFile.new, nil, 3)
  end
  
  test "should return file.id for existing file" do
    assert_equal 3, index_file_form(OrderFile.find(3), nil, 3)
  end
end
