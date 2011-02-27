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

Then /the talk submission should have been successful, with presenter: "([^"]+)"/ do |presenter_name|
  Then 'I should see "Your exceedingly awesome talk was added to the list. Good luck!"'
  When 'I go to the talks page'
  Then 'I should see "My Spiffy Talk" within ".talk .title"'
  Then 'I should see "'+presenter_name+'" within ".talk .presenter"'
end

