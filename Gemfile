source 'http://rubygems.org'

gem 'rails', '3.0.3'

gem 'capistrano'
gem 'haml'

gem 'authlogic',  :git => 'https://github.com/odorcicd/authlogic.git',      :branch => 'rails3'

gem 'dynamic_form'

gem 'jquery-rails', '>= 0.2.6'

group :development do
  gem 'sqlite3-ruby', :require => 'sqlite3'
end

group :production do
  gem 'mysql2'
end

group :test do
  gem 'cucumber'
  gem 'cucumber-rails'
  gem 'capybara'
  gem 'pickle'
  gem 'launchy'
  gem 'machinist', '>= 2.0.0.beta2'
  gem 'sham'
  gem 'faker'
  gem 'database_cleaner'
end
