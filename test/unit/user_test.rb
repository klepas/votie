require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should fail if user doesn't have twitter name" do
    user = User.new(:twitter_name => '')
    assert_equal false, user.valid?
  end


  test "should fail if user tries to vote too many times" do
    
  end


  test "should fail if user votes more than once on a talk" do
  end

  
  test ""

end
