require 'test_helper'

class ScrollsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:scrolls)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create scroll" do
    assert_difference('Scroll.count') do
      post :create, :scroll => { }
    end

    assert_redirected_to scroll_path(assigns(:scroll))
  end

  test "should show scroll" do
    get :show, :id => scrolls(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => scrolls(:one).to_param
    assert_response :success
  end

  test "should update scroll" do
    put :update, :id => scrolls(:one).to_param, :scroll => { }
    assert_redirected_to scroll_path(assigns(:scroll))
  end

  test "should destroy scroll" do
    assert_difference('Scroll.count', -1) do
      delete :destroy, :id => scrolls(:one).to_param
    end

    assert_redirected_to scrolls_path
  end
end
