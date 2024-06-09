require "test_helper"

class MessageTest < ActiveSupport::TestCase
  test "requires a body" do
    message = Message.new body: nil

    refute message.valid?
    assert_includes message.errors[:body], "can't be blank"
  end

  test "defaults to being from a user" do
    message = Message.new body: "A message with no 'from' specified."

    assert_equal "user", message.from
  end

  test "from must be present" do
    message = Message.new body: "A message with no 'from' specified.", from: ""

    refute message.valid?
    assert_includes message.errors[:from], "can't be blank"
  end
end
