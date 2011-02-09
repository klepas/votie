require 'test_helper'

class TalksControllerTest < ActionController::TestCase
  def setup
    @conference = Conference.first
    @request.host = "#{@conference.subdomain}.local.host"
  end

  test "should get top talks page" do
    get :index
    assert_response :success
    
    talks = @conference.talks
    talks = talks.sort_by { |talk| [talk.votes.count, talk.id] }
    talks.reverse!

    assert_equal talks, assigns(:talks)
  end


  test "should get voting page" do
    UserSession.create(users(:one))
    get :vote
    assert_response :success

    assert_equal [4, 3, 2, 1], assigns(:talks).map { |t| t.id }
  end


  test "should get presenters page" do
    UserSession.create(users(:one))
    get :presenters
    assert_response :success

    assert_equal [1, 2], assigns(:presenters).map { |p| p.id }
  end


  test "should get new talk page" do
    UserSession.create(users(:one))
    get :new
    assert_response :success
  end


  test "create should fail on missing fields" do
    UserSession.create(users(:one))

    # Title
    assert_difference('Talk.count', 0) do
      post :create, {:talk => {:title => '', :description => 'description', :link => 'linky'}}
    end
    assert_response :success

    # Description
    assert_difference('Talk.count', 0) do
      post :create, {:talk => {:title => 'Title', :description => '', :link => 'linky'}}
    end
    assert_response :success
  end


  test "should create talk" do
    title = 'title'
    description = 'description'
    link = 'http://link.com'

    assert_difference('Talk.count') do
      UserSession.create(users(:one))
      post(:create,
           {:talk => {:title => title,
                      :description => description,
                      :link => link}})
    end

    assert_redirected_to talks_url

    talk = assigns(:talk)
    assert_equal users(:one), talk.presenter
    assert_equal title, talk.title
    assert_equal description, talk.description
    assert_equal link, talk.link
  end


  test "should get edit talk page" do
    UserSession.create(users(:one))
    get :edit, {:id => talks(:one).id}
    assert_response :success
  end


  test "edit should redirect if editing someone else's talk" do
    UserSession.create(users(:two))
    get :edit, {:id => talks(:one).id}
    assert_redirected_to talks_path
    assert_equal "You may not edit someone else's talk.", flash[:notice]
  end


  test "should update guest" do
    title = 'new title'
    description = 'new description'
    link = 'http://new-link.com'

    # Check vars
    assert_not_equal title, talks(:one).title
    assert_not_equal description, talks(:one).description
    assert_not_equal link, talks(:one).link

    UserSession.create(users(:one))
    put(:update,
        {:id => talks(:one).id,
         :talk => {:title => title,
                   :description => description,
                   :link => link,
          }})

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

    UserSession.create(users(:two))
    put(:update,
        {:id => talks(:one).id,
         :talk => {:title => title,
                   :description => description,
                   :link => link,
          }})

    assert_redirected_to talks_path
    assert_equal "You may not edit someone else's talk.", flash[:notice]
  end


  test "should show cast vote links" do
    UserSession.create(users(:one))
    get :vote
    assert_response :success

    # There's four talks. We've already voted on talks(:two), but we should have cast vote links for the rest.
    assert_select "a", {:text => "Cast vote", :count => 3}
  end


  test "should not show cast vote links when all votes used" do
    # Vote on a few more talks
    users(:one).vote!(talks(:one))
    users(:one).vote!(talks(:three))

    UserSession.create(users(:one))
    get :vote
    assert_response :success

    assert_select "a", {:text => "Cast vote", :count => 0}
  end


  test "should show remove vote link" do
    UserSession.create(users(:one))
    get :vote
    assert_response :success

    # There's four talks. We've already voted on talks(:two), so we should have one remove vote link.
    assert_select "a", {:text => "Remove vote", :count => 1}
  end

end
