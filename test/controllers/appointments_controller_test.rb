require "test_helper"

class AppointmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @client = clients(:one)
    @appointment = appointments(:one)
    sign_in_as(@user)
  end

  test "should get index" do
    get client_appointments_url(client_id: @client.id)
    assert_response :success
  end

  test "should get show" do
    get appointment_url(id: @appointment.id)
    assert_response :success
  end

  test "should get new" do
    get new_client_appointment_url(client_id: @client.id)
    assert_response :success
  end

   test "should get edit" do
    get edit_appointment_url(id: @appointment.id)
    assert_response :success
  end

  test "should create a new appointment and redirect to appointment#show" do
    post client_appointments_url(client_id: @client.id), params: { appointment: { scheduled_at: Date.tomorrow, location: "office", status: "completed" } }
    assert_redirected_to appointment_url(id: Appointment.last)
  end

  test "should not create appointment with invalid data" do
    post client_appointments_url(client_id: @client.id), params: { appointment: { scheduled_at: "" } }
    assert_response :unprocessable_entity
  end

  test "should edit an appointment and redirect to appointment#show" do
    put appointment_url(id: @appointment.id), params: { appointment: { location: "virtual", status: "scheduled", scheduled_at: Date.tomorrow, duration_minutes: "65" } }
    assert_redirected_to appointment_url(id: @appointment.id)
  end

  test "should not edit appointment with invalid data" do
    put appointment_url(id: @appointment.id), params: { appointment: { scheduled_at: "" } }
    assert_response :unprocessable_entity
  end

  test "should destroy an appointment and redirect to apppointment#index" do
    delete appointment_url(id: @appointment.id)
    assert_redirected_to client_appointments_url(client_id: @client.id)
  end
end
