require "test_helper"

class AppointmentTest < ActiveSupport::TestCase
  setup do
    @client = clients(:one)
    @appointment = @client.appointments.build(
      scheduled_at: 1.day.from_now,
      location: :office,
      status: :scheduled,
      duration_minutes: 60
    )
  end

  # ✅ Basic validity
  test "is valid with valid attributes" do
    assert @appointment.valid?
  end

  # ✅ Associations
  test "belongs to a client" do
    assert_equal @client, @appointment.client
  end

  test "has a user through client" do
    assert_respond_to @appointment, :user
  end

  test "has many notes" do
    assert_respond_to @appointment, :notes
  end

  # ✅ Validations
  test "requires scheduled_at in the future" do
    @appointment.scheduled_at = 1.day.ago
    assert_not @appointment.valid?
  end

  test "requires duration_minutes > 0" do
    @appointment.duration_minutes = 0
    assert_not @appointment.valid?
    @appointment.duration_minutes = -10
    assert_not @appointment.valid?
  end

  test "requires location and status" do
    @appointment.location = nil
    assert_not @appointment.valid?
    @appointment.location = :office
    @appointment.status = nil
    assert_not @appointment.valid?
  end

  # ✅ Enums
  test "has valid enum mappings for location" do
    expected = { "office" => 0, "virtual" => 1, "phone" => 2 }
    assert_equal expected, Appointment.locations
  end

  test "has valid enum mappings for status" do
    expected = { "scheduled" => 0, "completed" => 1, "canceled" => 2, "no_show" => 3 }
    assert_equal expected, Appointment.statuses
  end

  test "can use enum methods and scopes" do
    @appointment.status = :completed
    assert @appointment.completed?
    assert_includes Appointment.statuses.keys, "completed"

    @appointment.location = :virtual
    assert @appointment.virtual?
  end

  # ✅ Scopes
  test ".upcoming returns future appointments only" do
    assert_includes Appointment.upcoming, appointments(:upcoming_appointment)
    refute_includes Appointment.upcoming, appointments(:past_appointment)
  end

  # ✅ Instance methods
  test "#formatted_scheduled_at returns nicely formatted date" do
    formatted = @appointment.formatted_scheduled_at
    assert_match(/\A[A-Z][a-z]{2} \d{2}, \d{4} at \d{2}:\d{2} [AP]M\z/, formatted)
  end

  # ✅ Dependent destroy
  test "destroys associated notes when destroyed" do
    appointment = appointments(:one)
    assert_difference("Note.count", -appointment.notes.count) do
      appointment.destroy
    end
  end
end
