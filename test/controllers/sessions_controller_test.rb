require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should get new" do
    get new_session_url
    assert_response :success
  end

  test "should log in with valid credentials" do
    post session_url, params: { email_address: @user.email_address, password: "password" }
    assert_redirected_to root_url
  end

  test "should not log in with invalid credentials" do
    post session_url, params: { email_address: @user.email_address, password: "wrongpassword" }
    assert_redirected_to new_session_url
  end

  test "should log out" do
    post session_url, params: { email_address: @user.email_address, password: "password" }
    delete session_url
    assert_redirected_to new_session_path
  end
end
