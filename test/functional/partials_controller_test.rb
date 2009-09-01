require 'test_helper'

class PartialsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:partials)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create partial" do
    assert_difference('Partial.count') do
      post :create, :partial => { }
    end

    assert_redirected_to partial_path(assigns(:partial))
  end

  test "should show partial" do
    get :show, :id => partials(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => partials(:one).to_param
    assert_response :success
  end

  test "should update partial" do
    put :update, :id => partials(:one).to_param, :partial => { }
    assert_redirected_to partial_path(assigns(:partial))
  end

  test "should destroy partial" do
    assert_difference('Partial.count', -1) do
      delete :destroy, :id => partials(:one).to_param
    end

    assert_redirected_to partials_path
  end
end
