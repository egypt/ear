require 'test_helper'

class HostsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hosts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create host" do
    assert_difference('Host.count') do
      post :create, :host => { }
    end

    assert_redirected_to host_path(assigns(:host))
  end

  test "should show host" do
    get :show, :id => hosts(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => hosts(:one).to_param
    assert_response :success
  end

  test "should update host" do
    put :update, :id => hosts(:one).to_param, :host => { }
    assert_redirected_to host_path(assigns(:host))
  end

  test "should destroy host" do
    assert_difference('Host.count', -1) do
      delete :destroy, :id => hosts(:one).to_param
    end

    assert_redirected_to hosts_path
  end
end
