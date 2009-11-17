require 'test_helper'

class TalkTest < ActiveSupport::TestCase
  test "should fail on missing fields" do
    # Title
    talk = Talk.new(:title => '', :presenter => users(:one), :description => 'description', :link => 'linky')
    assert_equal false, talk.valid?

    # Presenter
    talk = Talk.new(:title => 'title', :presenter => nil, :description => 'description', :link => 'linky')
    assert_equal false, talk.valid?

    # Description
    talk = Talk.new(:title => 'title', :presenter => users(:one), :description => '', :link => 'linky')
    assert_equal false, talk.valid?
  end


  test "should fail if description is longer than 140 chars" do
    talk = Talk.new(:title => 'title', :presenter => users(:one), :description => 'a'*141, :link => 'linky')
    assert_equal false, talk.valid?
  end


  test "should create talk" do
    assert_difference('Talk.count', 1) do
      talk = Talk.new(:title => 'title', :presenter => users(:one), :description => 'description', :link => 'linky')
      talk.save!
    end
  end
end
