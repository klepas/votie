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


  test "should fail if user tries to vote too many times" do
    assert_equal 3, Conference::NUM_VOTES_PER_USER
    assert_equal 3, users(:two).num_votes_remaining(conferences(:one))

    # Vote up to the maximum
    users(:two).vote! talks(:one)
    users(:two).vote! talks(:two)
    users(:two).vote! talks(:three)

    # Check that we can't vote again
    assert_equal 0, users(:two).num_votes_remaining(conferences(:one))
    vote = Vote.new(:user => users(:two), :talk => talks(:four))
    assert_equal false, vote.valid?

    # Check that we can still vote on a talk in a different conference
    assert_equal 3, users(:two).num_votes_remaining(conferences(:two))
    vote = Vote.new(:user => users(:two), :talk => talks(:in_conference_two))
    assert_equal true, vote.valid?
  end


  test "should fail if user votes more than once on a talk" do
    users(:two).vote! talks(:one)
    
    vote = Vote.new(:user => users(:two), :talk => talks(:one))
    assert_equal false, vote.valid?
  end


  test "should create vote" do
    assert_difference('Vote.count', 1) do
      vote = Vote.new(:user => users(:two), :talk => talks(:one))
      vote.save!
    end
  end
end
