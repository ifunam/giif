require File.dirname(__FILE__) + '/../test_helper'
require 'action_controller/test_case'
require 'application_helper'
require 'action_view/helpers/form_options_helper'

class ApplicationHelperTest < ActionController::TestCase
  fixtures :users, :order_statuses
  include ApplicationHelper
  include ActionView::Helpers::FormOptionsHelper

  def setup
    @request = ActionController::TestRequest.new
  end

  def test_logged_user
    @controller = SessionsController.new
    @request = ActionController::TestRequest.new
    @response = ActionController::TestResponse.new
    
    post :signup, :user => {:login => "alex", :password => "maltiempo" }
    
    assert_equal "alex", logged_user
  end

  def test_simple_select
    assert_dom_equal %Q(<select name=\"form[order_status_id]\" id=\"form_order_status_id\"><option value=\"\">--Seleccionar--</option>\n<option value=\"1\">Sin enviar</option>\n<option value=\"2\">En proceso</option>\n<option value=\"3\">Aprobado</option>\n<option value=\"4\">Rechazado</option></select>), simple_select(:form, OrderStatus)
  end
end
