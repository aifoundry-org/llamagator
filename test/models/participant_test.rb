require "test_helper"

class ParticipantTest < ActiveSupport::TestCase
  test "a name is required" do
    participant = participants(:one)
    participant.name = ""

    refute participant.valid?
    assert_includes participant.errors[:name], "can't be blank"
  end
end
