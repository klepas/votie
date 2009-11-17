require 'test_helper'

class VoteTest < ActiveSupport::TestCase
  test "should fail on missing fields" do
    # User
    vote = Vote.new(:user => nil, :talk => talks(:one))
    assert_equal false, vote.valid?

    # Talk
    vote = Vote.new(:user => users(:one), :talk => nil)
    assert_equal false, vote.valid?
  end
end
