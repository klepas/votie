Given /^I visit the subdomain "([^"]+)"$/ do |subdomain|
  host! "#{subdomain}.example.com"
  Capybara.default_host = "#{subdomain}.example.com"
  Capybara.app_host = "http://#{subdomain}.example.com:9887" if Capybara.current_driver == :culerity
end
