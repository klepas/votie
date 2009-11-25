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


  test "should get presenters page" do
    get :presenters, {}, {:user_id => users(:one).id}
    assert_response :success

    assert_equal [1, 2], assigns(:presenters).map { |p| p.id }
  end


  test "should get new talk page" do
    get :new, {}, {:user_id => users(:one).id}
    assert_response :success
  end


  test "create should fail on missing fields" do
    # Title
    assert_difference('Talk.count', 0) do
      post :create, {:talk => {:title => '', :description => 'description', :link => 'linky'}}, {:user_id => users(:one).id}
    end
    assert_response :success

    # Description
    assert_difference('Talk.count', 0) do
      post :create, {:talk => {:title => 'Title', :description => '', :link => 'linky'}}, {:user_id => users(:one).id}
    end
    assert_response :success
  end


  test "should create talk" do
    title = 'title'
    description = 'description'
    link = 'link'

    assert_difference('Talk.count') do
      post(:create,
           {:talk => {:title => title,
                      :description => description,
                      :link => link}},
           {:user_id => users(:one).id})
    end

    assert_redirected_to talks_url

    talk = assigns(:talk)
    assert_equal users(:one), talk.presenter
    assert_equal title, talk.title
    assert_equal description, talk.description
    assert_equal link, talk.link
  end


  test "should get edit talk page" do
    get :edit, {:id => talks(:one).id}, {:user_id => users(:one).id}
    assert_response :success
  end


  test "edit should redirect if editing someone else's talk" do
    get :edit, {:id => talks(:one).id}, {:user_id => users(:two).id}
    assert_redirected_to talks_path
    assert_equal "You may not edit someone else's talk.", flash[:notice]
  end


  test "should update guest" do
    title = 'new title'
    description = 'new description'
    link = 'new link'

    # Check vars
    assert_not_equal title, talks(:one).title
    assert_not_equal description, talks(:one).description
    assert_not_equal link, talks(:one).link

    put(:update,
        {:id => talks(:one).id,
         :talk => {:title => title,
                   :description => description,
                   :link => link,
          }},
        {:user_id => users(:one).id})
    assert_redirected_to talks_path

    talks(:one).reload
    assert_equal title, talks(:one).title
    assert_equal description, talks(:one).description
    assert_equal link, talks(:one).link
  end


  test "should fail if editing someone else's talk" do
    title = 'new title'
    description = 'new description'
    link = 'new link'

    put(:update,
        {:id => talks(:one).id,
         :talk => {:title => title,
                   :description => description,
                   :link => link,
          }},
        {:user_id => users(:two).id})
    assert_redirected_to talks_path
    assert_equal "You may not edit someone else's talk.", flash[:notice]
  end
end
