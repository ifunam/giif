require File.dirname(__FILE__) + '/../test_helper'
require 'mocha'

class OrderRequestsControllerTest < ActionController::TestCase
  fixtures :users, :people, :addresses, :adscriptions, :user_adscriptions,
    :order_statuses, :orders, :order_products,:currencies, :currency_orders, 
    :order_files, :project_types, :projects


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
    @request.session[:currency] = Currency.new(:name => 'Dólar nigeriano', :url => 'http://www.currencyexchange.com')
    @request.session[:currency_order] = CurrencyOrder.new(:order_id => 1, :currency_id => 2, :value => 13.45)

    post :create, { :products => { :new => [
                                            {:description => 'Notebook', :price_per_unit => 789.00, :quantity => 2, :product_category_id => 2},
                                            {:description => 'Server', :price_per_unit => 1980.00, :quantity => 3, :product_category_id => 3}
                                           ]
                                 },
                    :providers => { :new => [
                                             {:name => 'Proveedor A'},
                                             {:name => 'Proveedor B'}
                                            ]
                                  },
                    :files => {:new =>[
                                       { :file_type_id => 1, :file => fixture_file_upload('../../public/images/rails.png', 'image/png', :binary)}
                                      ]
                              },
                    :projects => {:new => [
                                           { :name => 'Proyecto de investigación en ciencia de materiales', :key => '123-Q', :project_type_id => 2}
                                          ]
                                 },
                    :multipart => true
                  }
 
    assert_redirected_to :action => 'index'
  end

  def test_should_not_create_order_with_not_valid_description_of_products
    @request.session[:user] = User.find_by_login('fernando').id
    @request.session[:currency] = Currency.new(:name => 'Dólar nigeriano', :url => 'http://www.currencyexchange.com')
    @request.session[:currency_order] = CurrencyOrder.new(:order_id => 1, :currency_id => 2, :value => 13.45)

    post :create, { :products => { :new => [
                                            {:description => nil, :price_per_unit => 789.00, :quantity => 2, :product_category_id => 3},
                                            {:description => 'Server', :price_per_unit => 1980.00, :quantity => 3, :product_category_id => 3}
                                           ]
                  },
                    :providers => { :new => [
                                             {:name => 'Proveedor A'},
                                             {:name => 'Proveedor B'}
                                            ]
                  },
                    :files => {:new =>[
                                       { :file_type_id => 1, :file => fixture_file_upload('../../public/images/rails.png', 'image/png', :binary)}
                                      ]
                  },
                    :projects => {:new => [
                                           { :name => 'Proyecto de investigación en ciencia de materiales', :key => '123-Q', :project_type_id => 2}
                                          ]
                  },
                    :multipart => true
                  }

    assert_template 'new'
  end

  def test_should_get_edit
    @request.session[:user] = User.find_by_login('fernando').id
    get :edit, :id => 1
    assert_template 'edit'
  end

  def test_should_get_show
    @request.session[:user] = User.find_by_login('fernando').id
    get :show, :id => 1
    assert_template 'show'
  end

  def test_should_post_update
    @request.session[:user] = User.find_by_login('fernando').id
    @request.session[:currency] = Currency.new(:name => 'Dólar nigeriano', :url => 'http://www.currencyexchange.com')
    @request.session[:currency_order] = CurrencyOrder.new(:order_id => 1, :currency_id => 2, :value => 13.45)

    post :update, { :id => 1,
                    :products => { :new => [
                                            {:description => 'Notebook', :price_per_unit => 789.00, :quantity => 2, :product_category_id => 2},
                                            {:description => 'Server', :price_per_unit => 1980.00, :quantity => 3, :product_category_id => 3}
                                           ]
                                 },
                    :providers => { :new => [
                                             {:name => 'Proveedor A'},
                                             {:name => 'Proveedor B'}
                                            ]
                                  },
                    :files => {:existing => { 1 =>{ 
                                                   :file_type_id => 1, :file => fixture_file_upload('../../public/images/rails.png', 'image/png', :binary)
                                                  }
                                            }
                              },
                    :projects => {:new => [
                                           { :name => 'Proyecto de investigación en ciencia de materiales', :key => '123-Q', :order_id => 1, :project_type_id => 2}
                                          ]
                                  },
                    :multipart => true
    }

    assert_template 'show'
  end

  def test_should_not_update_with_invalid_params
    @request.session[:user] = User.find_by_login('fernando').id
    @request.session[:currency] = Currency.new(:name => 'Dólar nigeriano', :url => 'http://www.currencyexchange.com')
    @request.session[:currency_order] = CurrencyOrder.new( :currency_id => 2, :value => 13.45, :order_id => 1)


    post :update, { :id => 1, :products => { :new => [
                                                      {:description => nil, :price_per_unit => 789.00, :quantity => 2, :product_category_id => 2},
                                                      {:description => 'Server', :price_per_unit => 1980.00, :quantity => 3, :product_category_id => 1}
                                                     ]
      },
      :providers => { :new => [
                               {:name => 'Proveedor A'},
                               {:name => 'Proveedor B'}
                              ]
      },
      :files => {:existing => { 1 =>{ 
                                     :file_type_id => 1, :file => fixture_file_upload('../../public/images/rails.png', 'image/png', :binary)
                                    }
                              }
                },

      :projects => {:new => [
                             { :name => 'Proyecto de investigación en ciencia de materiales', :key => '123-Q', :project_type_id => 2, :order_id => 1}
                            ]
      },
      :multipart => true
    }

    assert_template 'edit'
  end

  def test_should_destroy
    @request.session[:user] = User.find_by_login('fernando').id
    delete :destroy, :id => 1
    assert :success
    assert_redirected_to :action => 'index'
  end

  def test_should_send_order
    @request.session[:user] = User.find_by_login('fernando').id
    @request.session[:currency] = Currency.new(:name => 'Dólar nigeriano', :url => 'http://www.currencyexchange.com')
    @request.session[:currency_order] = CurrencyOrder.new( :currency_id => 2, :value => 13.45, :order_id => 1)

    post :send_order, { :id => 1, :user => 'alex'}
    assert :success
    assert_template 'send_order.rjs'
  end

  def test_should_send_order_to_user_incharge_too
    @request.session[:user] = User.find_by_login('alex').id
    post :send_order, { :id => 1, :user => 'alex'}
    assert_template 'send_order.rjs'
  end

  def test_should_not_send_order
    @request.session[:user] = User.find_by_login('fernando').id
    @order = Order.find(1)
    @order.change_to_sent_status
    post :send_order, { :id => 1, :user => 'memo'}
    assert_template 'errors.rjs'
  end

  def test_should_destroy_item
    @request.session[:user] = User.find_by_login('fernando').id
    delete :destroy_item, :id => 1, :table => 'order_product'
    assert :success
    assert_template 'destroy_item.rjs'
  end

  def test_should_get_file
    @request.session[:user] = User.find_by_login('fernando').id
    @request.session[:currency] = Currency.new(:name => 'Dólar nigeriano', :url => 'http://www.currencyexchange.com')
    @request.session[:currency_order] = CurrencyOrder.new( :currency_id => 2, :value => 13.45, :order_id => 1)

    post :create, { :id => 1,
      :products => { :new => [{:description => 'Notebook', :price_per_unit => 789.00, :quantity => 2, :product_category_id => 2},
                              {:description => 'Server', :price_per_unit => 1980.00, :quantity => 3, :product_category_id => 3}
                             ]
      },
      :providers => { :new => [{:name => 'Proveedor A'},
                               {:name => 'Proveedor B'}
                              ]
      },
      :files => {:new =>[{ :file_type_id => 1, :file => fixture_file_upload('../../public/images/rails.png', 'image/png', :binary)}
                        ]
      },
      :projects => {:new => [{ :name => 'Proyecto de investigación en ciencia de materiales', :key => '123-Q', :project_type_id => 2}
                            ]
      },
      :multipart => true
    }
    @record = Order.find(:last)
    get :get_file, :id => @record.order_file.id
    assert_response 200
  end

end
