require 'test_helper'

class VotesControllerTest < ActionController::TestCase
  def setup
    @conference = Conference.first
    @request.host = "#{@conference.subdomain}.local.host"
  end

  test "should cast vote" do
    assert_equal false, users(:one).voted_for?(talks(:one))

    assert_difference('Vote.count') do
      UserSession.create(users(:one))
      get :cast, {:id => talks(:one).id}
      assert_redirected_to vote_path
    end

    assert_equal true, users(:one).voted_for?(talks(:one))
  end


  test "should remove vote" do
    assert_equal true, users(:one).voted_for?(talks(:two))

    assert_difference('Vote.count', -1) do
      UserSession.create(users(:one))
      get :remove, {:id => talks(:two).id}
      assert_redirected_to vote_path
    end

    assert_equal false, users(:one).voted_for?(talks(:one))
  end

end
