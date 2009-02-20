require File.dirname(__FILE__) + '/../test_helper'
require 'action_controller/test_case'
require 'application_helper'
require 'action_view/helpers/form_options_helper'

class ApplicationHelperTest < ActionController::TestCase
  fixtures :users, :order_statuses
  include ApplicationHelper
  include ActionView::Helpers::FormOptionsHelper

  test "should return the login of a logged user" do
    @request = ActionController::TestRequest.new
    @request.session[:user] = User.find_by_login('alex').id
    assert_equal "alex", logged_user
  end

  test "should render a simple select html list" do
    assert_dom_equal %Q(<select name=\"form[order_status_id]\" id=\"form_order_status_id\"><option value=\"\">--Seleccionar--</option>\n<option value=\"1\">Sin enviar</option>\n<option value=\"2\">En proceso</option>\n<option value=\"3\">Aprobado</option>\n<option value=\"4\">Rechazado</option></select>), simple_select(:form, OrderStatus)
  end
end
