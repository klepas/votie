require 'test_helper'

class TalkTest < ActiveSupport::TestCase
  test "should fail on missing fields" do
    # Title
    talk = Talk.new(:title => '', :description => 'description', :link => 'linky',
                    :creator => users(:one), :presenter => users(:one))
    assert_equal false, talk.valid?

    # Creator
    talk = Talk.new(:title => 'title', :description => 'description', :link => 'linky',
                    :creator => nil, :presenter => users(:one))
    assert_equal false, talk.valid?

    # Presenter
    talk = Talk.new(:title => 'title', :description => 'description', :link => 'linky',
                    :creator => users(:one), :presenter => nil)
    assert_equal false, talk.valid?

    # Description
    talk = Talk.new(:title => 'title', :description => '', :link => 'linky',
                    :creator => users(:one), :presenter => users(:one))
    assert_equal false, talk.valid?
  end


  test "should fail if description is longer than 140 chars" do
    talk = Talk.new(:title => 'title', :description => 'a'*141, :link => 'linky',
                    :creator => users(:one), :presenter => users(:one))
    assert_equal false, talk.valid?
  end


  test "should create talk" do
    assert_difference('Talk.count', 1) do
      talk = Talk.new(:title => 'title', :description => 'description', :link => 'linky',
                      :creator => users(:one), :presenter => users(:one))
      talk.save!
    end
  end


  test "should get all talks ordered by votes" do
    talks = Talk.ordered_by_votes
    assert_equal [2, 5, 4, 3, 1], talks.map {|t| t.id}
  end


  test "should get number of votes" do
    assert_equal 0, talks(:one).num_votes
    assert_equal 1, talks(:two).num_votes
  end
end
