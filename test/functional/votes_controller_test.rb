require 'test_helper'

class VotesControllerTest < ActionController::TestCase
  test "should cast vote" do
    assert_equal false, users(:one).voted_for?(talks(:one))

    assert_difference('Vote.count') do
      get :cast, {:id => talks(:one).id}, {:user_id => users(:one).id}
      assert_redirected_to vote_path
    end

    assert_equal true, users(:one).voted_for?(talks(:one))
  end


  test "should remove vote" do
    assert_equal true, users(:one).voted_for?(talks(:two))

    assert_difference('Vote.count', -1) do
      get :remove, {:id => talks(:two).id}, {:user_id => users(:one).id}
      assert_redirected_to vote_path
    end

    assert_equal false, users(:one).voted_for?(talks(:one))
  end

end
