require 'test_helper'

class ImageFilesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:image_files)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create image_file" do
    assert_difference('ImageFile.count') do
      post :create, :image_file => { }
    end

    assert_redirected_to image_file_path(assigns(:image_file))
  end

  test "should show image_file" do
    get :show, :id => image_files(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => image_files(:one).to_param
    assert_response :success
  end

  test "should update image_file" do
    put :update, :id => image_files(:one).to_param, :image_file => { }
    assert_redirected_to image_file_path(assigns(:image_file))
  end

  test "should destroy image_file" do
    assert_difference('ImageFile.count', -1) do
      delete :destroy, :id => image_files(:one).to_param
    end

    assert_redirected_to image_files_path
  end
end
