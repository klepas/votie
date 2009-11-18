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
end
