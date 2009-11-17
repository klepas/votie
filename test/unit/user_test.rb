require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should fail if user doesn't have twitter name" do
    user = User.new(:twitter_name => '')
    assert_equal false, user.valid?
  end


  test "should cast a vote" do
    assert_equal false, users(:two).voted_for?(talks(:two))

    assert_difference('Vote.count', 1) do
      users(:two).vote! talks(:two)
    end

    assert_equal true, users(:two).voted_for?(talks(:two))
  end

  
  test "should create user" do
    assert_difference('User.count', 1) do
      user = User.new(:twitter_name => 'name')
      user.save!
    end
  end
end
