require File.dirname(__FILE__) + '/../test_helper'

class FilesControllerTest < ActionController::TestCase

  remote_fixtures
  
  def setup
    provider_session_as('HP México')
    @mock_file = mock('file')
  end
  
  test "should get edit" do
    get :edit, :estimate_id => 1
    
    assert_template 'edit'
  end

  test "should update order files" do 
    post :update,:id => 1, :order => {
                                      :files_attributes => { "0" => {
                                                                     :file => @mock_file, :file_type_id => 2                                             }
                                                            }
                                     }
    assert_redirected_to :controller => 'provider_sessions', :action => 'destroy'
  end

  test "should not update invalid order files" do 
    post :update,:id => 1, :order => {
                                      :files_attributes => { "0" => {
                                                                     :file => nil, :file_type_id => nil                                                  }
                                                            }
                                     }
    
    assert_template 'edit'
  end

  
end
