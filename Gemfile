source 'https://rubygems.org'

git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.2'

gem 'bootsnap', '>= 1.4.4', require: false
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rack-cors'
gem 'rails', '~> 6.1.4', '>= 6.1.4.1'

group :development, :test do
  gem 'ffaker'
  gem 'pry-rails'
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'rubocop-rails', require: false
  gem 'spring'
end

group :test do
  gem 'factory_bot_rails'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'simplecov'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
