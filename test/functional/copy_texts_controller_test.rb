require 'test_helper'

class CopyTextsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:copy_texts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create copy_text" do
    assert_difference('CopyText.count') do
      post :create, :copy_text => { }
    end

    assert_redirected_to copy_text_path(assigns(:copy_text))
  end

  test "should show copy_text" do
    get :show, :id => copy_texts(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => copy_texts(:one).to_param
    assert_response :success
  end

  test "should update copy_text" do
    put :update, :id => copy_texts(:one).to_param, :copy_text => { }
    assert_redirected_to copy_text_path(assigns(:copy_text))
  end

  test "should destroy copy_text" do
    assert_difference('CopyText.count', -1) do
      delete :destroy, :id => copy_texts(:one).to_param
    end

    assert_redirected_to copy_texts_path
  end
end
