require File.dirname(__FILE__) + '/../test_helper'

class OrderRequestsControllerTest < ActionController::TestCase
  fixtures :users, :people, :addresses, :adscriptions, :user_adscriptions,
    :order_statuses, :orders, :order_products

  def test_should_get_index
    @request.session[:user] = User.find_by_login('fernando').id
    get :index
    assert_response :success
    assert_template 'index'
  end

    def test_should_get_new
    @request.session[:user] = User.find_by_login('fernando').id
    get :new
    assert_response :success
    assert_template 'new'
    end

  def test_should_create_order
    @request.session[:user] = User.find_by_login('fernando').id
     post :create, { :products => { :new => [
                                               {:description => 'Notebook', :price_per_unit => 789.00, :quantity => 2},
                                               {:description => 'Server', :price_per_unit => 1980.00, :quantity => 3}
                                               ]
                                            },
                    :providers => { :new => [
                                             {:name => 'Proveedor A'},
                                             {:name => 'Proveedor B'}
                                             ]
                                            },
                    :order_files => {
                                :file_type_id => 1,
                                :file => fixture_file_upload('../../public/images/rails.png', 'image/png')
                              }            
                     },
                     :multipart => true
         assert_response :success
         assert_template 'show'
  end

  # def test_should_not_create_order_with_invalid_products
  #   @request.session[:user] = User.find_by_login('fernando').id
  #   post :create, { :products =>  { :new => [
  #                                  {:description => nil, :price_per_unit => 789.00, :quantity => 2},
  #                                  {:description => 'Server', :price_per_unit => nil, :quantity => 3}
  #                                  ]
  #                                }
  #                 }
  #   assert_response :success
  #   assert_template 'new'
  # end

  #   def test_should_not_create_order_with_empty_product
  #   @request.session[:user] = User.find_by_login('fernando').id
  #     post :create, { :products =>  { :new => [ {:description => nil, :price_per_unit => nil, :quantity => nil} ]
  #                                   }
  #                   }
  #     assert_response :success
  #     assert_template 'new'
  # end
end
