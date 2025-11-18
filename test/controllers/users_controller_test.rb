require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should create user and redirect to root path" do
    post users_url, params: { user: { email_address: "test@test.com", password: "password" } }
    assert_redirected_to root_path
  end

  test "should not create user with invalid data" do
    post users_url, params: { user: { email_address: "", password: "password" } }
    assert_response :unprocessable_entity
  end

  test "should not create user with duplicate email" do
    existing_user = users(:one)
    post users_url, params: { user: { email_address: existing_user.email_address, password: "password" } }
    assert_response :unprocessable_entity
  end
end
