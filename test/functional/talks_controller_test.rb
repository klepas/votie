require 'test_helper'

class TalksControllerTest < ActionController::TestCase
  test "should get top talks page" do
    get :index
    assert_response :success

    talks = Talk.all
    talks = talks.sort_by { |talk| [talk.votes.count, talk.id] }
    talks.reverse!

    assert_equal talks, assigns(:talks)
  end


  test "should get voting page" do
    get :vote, {}, {:user_id => users(:one).id}
    assert_response :success

    assert_equal [4, 3, 2, 1], assigns(:talks).map { |t| t.id }
  end
end
