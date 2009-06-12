# encoding: utf-8

require File.dirname(__FILE__) + '/../test_helper'
require 'action_controller/test_case'
require 'application_helper'
require 'action_view/helpers/form_options_helper'

class ApplicationHelperTest < ActionController::TestCase
  fixtures :users, :order_statuses, :currencies
  include ApplicationHelper
  include ActionView::Helpers::FormOptionsHelper

  test "should return the login of a logged user" do
    @request = ActionController::TestRequest.new
    @request.session[:user] = User.find_by_login('alex').id
    assert_equal "alex", logged_user
  end

  test "should render a simple select html list" do
    assert_dom_equal %Q(<select name=\"form[order_status_id]\" id=\"form_order_status_id\"><option value=\"\">--Seleccionar--</option>\n<option value=\"8\">Adquisición en proceso</option>\n<option value=\"9\">Adquisición realizada</option>\n<option value=\"7\">Aprobado</option>\n<option value=\"2\">Cotización en proceso</option>\n<option value=\"1\">Cotización no enviada</option>\n<option value=\"4\">Presupuesto en progreso</option>\n<option value=\"5\">Rechazado</option>\n<option value=\"3\">Solicitud no enviada</option>\n<option value=\"10\">Solicitud sin cotización</option>\n<option value=\"6\">Transferencia</option></select>), simple_select(:form, OrderStatus)
  end
  
  test "should render a simple select html using ActiveRecord find options" do
    assert_dom_equal %Q(<select name=\"form[currency_id]\" id=\"form_currency_id\"><option value=\"\">--Seleccionar--</option>\n<option value=\"3\">Dólar Américano</option>\n<option value=\"2\">Euro</option>\n<option value=\"5\">Libra esterlina</option>\n<option value=\"6\">Otro</option>\n<option value=\"1\">Peso</option>\n<option value=\"4\">Yen</option></select>), simple_select(:form, Currency, :conditions => "id <= 6")
  end
end
