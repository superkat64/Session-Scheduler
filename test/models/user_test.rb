require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
  end

  # ✅ Basic validity
  test "is valid with fixtures" do
    assert @user.valid?
  end

  # ✅ has_secure_password creates password + password_confirmation handling
  test "requires a password to be valid when new" do
    user = User.new(email_address: "foo@example.com")
    assert_not user.valid?
    assert_includes user.errors[:password], "can't be blank"
  end

  test "authenticates with correct password" do
    assert @user.authenticate("password")
  end

  test "does not authenticate with incorrect password" do
    refute @user.authenticate("not_right")
  end

  # ✅ Associations
  test "has many clients" do
    assert_respond_to @user, :clients
    assert_equal 1, @user.clients.count
  end

  test "has many appointments through clients" do
    assert_respond_to @user, :appointments
    assert_equal 2, @user.appointments.count   # from fixtures
  end

  # ✅ Normalization
  test "normalizes email_address on save" do
    user = User.create!(
      email_address: "  MIXEDcase@Example.Com  ",
      password: "password"
    )

    assert_equal "mixedcase@example.com", user.email_address
  end

  # ✅ email uniqueness (if your schema enforces it)
  # uncomment if you have a unique index
  # test "email_address must be unique" do
  #   dup = User.new(email_address: @user.email_address, password: "password")
  #   assert_not dup.save, "Allowed duplicate email"
  #   assert_includes dup.errors[:email_address], "has already been taken"
  # end

  # ✅ Dependent destroys
  test "destroys associated clients when destroyed" do
    user = users(:one)
    assert_difference("Client.count", -user.clients.count) do
      user.destroy
    end
  end

  test "destroys appointments through clients when destroyed" do
    user = users(:one)
    assert_difference("Appointment.count", -user.appointments.count) do
      user.destroy
    end
  end
end
