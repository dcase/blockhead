require 'test_helper'

class SeoProfilesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:seo_profiles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create seo_profile" do
    assert_difference('SeoProfile.count') do
      post :create, :seo_profile => { }
    end

    assert_redirected_to seo_profile_path(assigns(:seo_profile))
  end

  test "should show seo_profile" do
    get :show, :id => seo_profiles(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => seo_profiles(:one).to_param
    assert_response :success
  end

  test "should update seo_profile" do
    put :update, :id => seo_profiles(:one).to_param, :seo_profile => { }
    assert_redirected_to seo_profile_path(assigns(:seo_profile))
  end

  test "should destroy seo_profile" do
    assert_difference('SeoProfile.count', -1) do
      delete :destroy, :id => seo_profiles(:one).to_param
    end

    assert_redirected_to seo_profiles_path
  end
end
