require "test_helper"

class ClientsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @client = clients(:one)

    # Sign in — this creates the proper session
    sign_in_as(@user)
  end

  test "should get index" do
    get clients_url
    assert_response :success
  end

  test "should get show" do
    get client_url(id: @client.id)
    assert_response :success
  end

  test "should get new" do
    get new_client_url
    assert_response :success
  end

  test "should get edit" do
    get edit_client_url(id: @client.id)
    assert_response :success
  end

  test "should create a new client and redirect to client#show" do
    post clients_url(), params: { client: { first_name: "John", last_name: "Doe", email: "j.doe@test.com", phone: "1234567890" } }
    assert_redirected_to client_url(Client.last)
  end

  test "should not create client with invalid data" do
    post clients_url(), params: { client: { first_name: "", last_name: "", email: "invalid", phone: "" } }
    assert_response :unprocessable_entity
  end

  test "should update a client and redirect to client#show" do
    put client_url(id: @client.id), params: { client: { first_name: "UpdatedName" } }
    assert_redirected_to client_url(@client)
  end

  test "should not update client with invalid data" do
    put client_url(id: @client.id), params: { client: { email: "" } }
    assert_response :unprocessable_entity
  end

  test "should destroy a client and redirect to client#index" do
    delete client_url(id: @client.id)
    assert_redirected_to clients_url
  end
end
