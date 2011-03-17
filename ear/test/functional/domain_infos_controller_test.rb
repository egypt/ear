require 'test_helper'

class DomainInfosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:domain_infos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create domain_info" do
    assert_difference('DomainInfo.count') do
      post :create, :domain_info => { }
    end

    assert_redirected_to domain_info_path(assigns(:domain_info))
  end

  test "should show domain_info" do
    get :show, :id => domain_infos(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => domain_infos(:one).to_param
    assert_response :success
  end

  test "should update domain_info" do
    put :update, :id => domain_infos(:one).to_param, :domain_info => { }
    assert_redirected_to domain_info_path(assigns(:domain_info))
  end

  test "should destroy domain_info" do
    assert_difference('DomainInfo.count', -1) do
      delete :destroy, :id => domain_infos(:one).to_param
    end

    assert_redirected_to domain_infos_path
  end
end
