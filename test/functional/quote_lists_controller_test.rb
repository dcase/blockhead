require 'test_helper'

class QuoteListsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:quote_lists)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create quote_list" do
    assert_difference('QuoteList.count') do
      post :create, :quote_list => { }
    end

    assert_redirected_to quote_list_path(assigns(:quote_list))
  end

  test "should show quote_list" do
    get :show, :id => quote_lists(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => quote_lists(:one).to_param
    assert_response :success
  end

  test "should update quote_list" do
    put :update, :id => quote_lists(:one).to_param, :quote_list => { }
    assert_redirected_to quote_list_path(assigns(:quote_list))
  end

  test "should destroy quote_list" do
    assert_difference('QuoteList.count', -1) do
      delete :destroy, :id => quote_lists(:one).to_param
    end

    assert_redirected_to quote_lists_path
  end
end
