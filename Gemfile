source 'https://rubygems.org'

gem 'rails', '~> 3.2'

gem 'jquery-rails', "~> 2.0"
gem 'pg', '~> 0.14'
gem 'rabl', "~> 0.7"
gem 'yajl-ruby', "~> 1.1"
gem "rails-backbone", "~> 0.7"

group :assets do
  gem 'sass-rails',   '~> 3.2'
  gem 'coffee-rails', '~> 3.2'
  gem 'therubyracer', :platforms => :ruby
  gem 'uglifier', '>= 1.0.3'
  gem 'twitter-bootstrap-rails', "~> 2.1"
end

group :development, :test do
  gem "rspec-rails", "~> 2.11"
  gem 'shoulda-matchers', "~> 1.2"
  gem 'factory_girl_rails', "~> 3.0"
  #gem 'capybara', "~> 1.1"
end

group :production do
  gem 'unicorn', "~> 4.3"
  gem 'newrelic_rpm', "~> 3.4"
end
