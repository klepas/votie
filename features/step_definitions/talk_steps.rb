Given /^a talk exists, created by "([^"]*)" and presented by "([^"]*)"$/ do |creator_name, presenter_name|
  creator = User.find_by_login!(creator_name)
  presenter = User.find_by_login!(presenter_name)
  talk = Talk.make!(:creator => creator, :presenter => presenter)
end

When /I fill in the talk details/ do
  When 'I fill in "talk_title" with "My Spiffy Talk"'
  When 'I fill in "talk_description" with "This talk is awesome!"'
  When 'I fill in "talk_link" with "http://google.com"'
end

When /I specify that the talk is presented by myself/ do
  When 'I choose "Myself"'
end

When /I specify that the talk is presented by "([^"]+)" with twitter name "([^"]+)"/ do |name, twitter_name|
  When 'I choose "Someone else"'
  When 'I fill in "talk_presenter_attributes_name" with "'+name+'"'
  When 'I fill in "talk_presenter_attributes_twitter_name" with "'+twitter_name+'"'
end

When /^I navigate to the edit talk page$/ do
  # Go to talks page and click on the edit link (in this situation, there should only be one)
  visit path_to('the talks page')
  find_link('Edit').click
end

When /^I fill in some differing details$/ do
  fill_in "talk_title", :with => "My Edited Talk"
  fill_in "talk_description", :with => "This talk has been edited."
  fill_in "talk_link", :with => "http://yahoo.com.au"
end

Then /the talk submission should have been successful, with presenter: "([^"]+)"/ do |presenter_name|
  Then 'I should see "Your exceedingly awesome talk was added to the list. Good luck!"'
  When 'I go to the talks page'
  Then 'I should see "My Spiffy Talk" within ".talk .title"'
  Then 'I should see "'+presenter_name+'" within ".talk .presenter"'
end

Then /^the talk update should have been successful$/ do
  Then 'I should see "The talk has been updated."'
  When 'I go to the talks page'
  Then 'I should see "My Edited Talk" within ".talk .title"'
  Then 'I should see "This talk has been edited." within ".talk .description"'
  Then %(I should see "More info" within "a[href = 'http://yahoo.com.au']")
end
