require "test_helper"

class NoteTest < ActiveSupport::TestCase
  setup do
    @appointment = appointments(:one)
    @note = @appointment.notes.build(content: "This is a test note.")
  end

  # ✅ Basic validity
  test "is valid with valid attributes" do
    assert @note.valid?
  end

  # ✅ Associations
  test "belongs to an appointment" do
    assert_equal @appointment, @note.appointment
  end

  test "has a client through appointment" do
    assert_equal @appointment.client, @note.client
  end

  test "has a user through client" do
    assert_equal @appointment.client.user, @note.user
  end

  # ✅ Validations
  test "requires content" do
    @note.content = nil
    assert_not @note.valid?
    assert_includes @note.errors[:content], "can't be blank"
  end

  test "rejects overly long content" do
    @note.content = "a" * 3000
    assert_not @note.valid?
    assert_includes @note.errors[:content], "is too long (maximum is 2000 characters)"
  end

  test "strips whitespace before save" do
    note = @appointment.notes.create!(content: "   lots of space   ")
    assert_equal "lots of space", note.content
  end
end
