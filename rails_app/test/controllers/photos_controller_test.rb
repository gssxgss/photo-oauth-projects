require "test_helper"

class PhotosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:test)
    @photo = photos(:test)
  end

  test "User should redirect to login unless logged in" do
    get photos_path
    assert_redirected_to login_path
  end

  test "User should view photos" do
    post login_path, params: {user_id: @user.user_id, password: 'password'}
    get root_path
    assert_response 200
    assert_equal 1, controller.instance_variable_get('@photos').length
  end

  test "User should fail on upload photo" do
    post login_path, params: {user_id: @user.user_id, password: 'password'}
    post photos_path, params: {}
    assert_response 400
  end

  test "User should upload photo" do
    post login_path, params: {user_id: @user.user_id, password: 'password'}
    post photos_path, params: {photo: {title: 'TITLE', image: file_fixture_upload('image.png')}}
    assert_redirected_to root_path
    assert_equal 2, @user.photos.length
  end

end
