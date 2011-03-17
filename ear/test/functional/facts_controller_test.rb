require 'test_helper'

class FactsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:facts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create fact" do
    assert_difference('Fact.count') do
      post :create, :fact => { }
    end

    assert_redirected_to fact_path(assigns(:fact))
  end

  test "should show fact" do
    get :show, :id => facts(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => facts(:one).to_param
    assert_response :success
  end

  test "should update fact" do
    put :update, :id => facts(:one).to_param, :fact => { }
    assert_redirected_to fact_path(assigns(:fact))
  end

  test "should destroy fact" do
    assert_difference('Fact.count', -1) do
      delete :destroy, :id => facts(:one).to_param
    end

    assert_redirected_to facts_path
  end
end
