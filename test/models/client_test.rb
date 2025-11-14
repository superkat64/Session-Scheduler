require "test_helper"

class ClientTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
    @client = @user.clients.build(
      first_name: "Jane",
      last_name: "Doe",
      email: "jane@example.com",
      phone: "+15551234567"
    )
  end

  # ✅ Basic validity
  test "is valid with valid attributes" do
    assert @client.valid?
  end

  # ✅ Associations
  test "belongs to a user" do
    assert_equal @user, @client.user
  end

  test "has many appointments" do
    assert_respond_to @client, :appointments
  end

  # ✅ Presence validations
  test "requires first_name, last_name, email, and phone" do
    %i[first_name last_name email phone].each do |field|
      @client.send("#{field}=", nil)
      assert_not @client.valid?, "Client should be invalid without #{field}"
      @client.send("#{field}=", "placeholder") # reset for next loop
    end
  end

  # ✅ Email validation
  test "requires valid email format" do
    @client.email = "not-an-email"
    assert_not @client.valid?
    assert_includes @client.errors[:email], "is invalid"
  end

  # ✅ Phone validation
  test "rejects invalid phone numbers" do
    @client.phone = "abc123"
    assert_not @client.valid?
    assert_includes @client.errors[:phone], "must be a valid phone number"
  end

  # ✅ Normalization
  test "normalizes email, phone, and names before validations" do
    messy = @user.clients.create!(
      first_name: " jAnE ",
      last_name: "doE ",
      email: "  JANE@Example.COM ",
      phone: "(555) 123-4567"
    )

    assert_equal "Jane", messy.first_name
    assert_equal "Doe", messy.last_name
    assert_equal "jane@example.com", messy.email
    assert_equal "5551234567".gsub(/[^0-9+]/, ""), messy.phone
  end

  # ✅ Instance methods
  test "#full_name concatenates first and last name" do
    assert_equal "Jane Doe", @client.full_name
  end

  # ✅ Dependent destroy
  test "destroys associated appointments when destroyed" do
    client = clients(:one)
    assert_difference("Appointment.count", -client.appointments.count) do
      client.destroy
    end
  end
end
