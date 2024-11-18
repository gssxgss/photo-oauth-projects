require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create!(user_id: 'test_id', password: 'password', password_confirmation: 'password')
  end

  test "User should login" do
    post login_path, params: {user_id: @user.user_id, password: @user.password}
    assert_redirected_to root_path
  end

  test "User should fail" do
    post login_path, params: {user_id: '', password: ''}
    errors = controller.instance_variable_get('@errors')
    assert_equal 2, errors.length
  end

  test "User should fail on wrong password" do
    post login_path, params: {user_id: @user.user_id, password: 'wrongPassword'}
    errors = controller.instance_variable_get('@errors')
    assert_equal 1, errors.length
  end

  test "User should logout" do
    post login_path, params: {user_id: @user.user_id, password: @user.password}
    delete logout_path
    assert_redirected_to login_path
  end

end
