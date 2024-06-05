require "test_helper"

class MessageTest < ActiveSupport::TestCase
  test "requires a body" do
    message = Message.new body: nil

    refute message.valid?
    assert_includes message.errors[:body], "can't be blank"
  end
end
