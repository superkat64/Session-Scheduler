require  'test_helper'

class NotesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @appointment = appointments(:one)
    @note = notes(:one)
    sign_in_as(@user)
  end

  test "should get show" do
    get note_url(id: @note.id)
    assert_response :success
  end

  test "should get new" do
    get new_appointment_note_url(appointment_id: @appointment.id)
    assert_response :success
  end

   test "should get edit" do
    get edit_note_url(id: @note.id)
    assert_response :success
  end

  test "should create a new note and redirect to appointment#show" do
    post appointment_notes_url(appointment_id: @appointment.id), params: { note: { content: "This is a test note." } }
    assert_redirected_to appointment_url(id: @appointment.id)
  end

  test "should not create note with invalid data" do
    post appointment_notes_url(appointment_id: @appointment.id), params: { note: { content: "" } }
    assert_response :unprocessable_entity
  end 

  test "should edit a note and redirect to appointment#show" do
    put note_url(id: @note.id), params: { note: { content: "Updated note content." } }
    assert_redirected_to appointment_url(id: @appointment.id)
  end

  test "should not edit note with invalid data" do
    put note_url(id: @note.id), params: { note: { content: "" } }
    assert_response :unprocessable_entity
  end

  test "should destroy a note and redirect to appointment#show" do
    delete note_url(id: @note.id)
    assert_redirected_to appointment_url(id: @appointment.id)
  end
end