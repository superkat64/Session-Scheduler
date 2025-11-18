require "test_helper"

class PasswordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  # Forgot Password Tests
  test "should get new password page" do
    get new_password_url
    assert_response :success
  end

  test "should create password reset and redirect to new session" do
    post passwords_url, params: { email_address: @user.email_address }
    # TODO: Add assertion to check that email was sent when mailers are set up
    assert_redirected_to new_session_url
  end
end
