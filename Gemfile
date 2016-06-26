source 'https://rubygems.org'
ruby '2.2.3'

gem 'rails', '4.2.5'
gem 'sass-rails', '~> 5.0'
gem 'bcrypt'
gem 'bootstrap-sass', '2.3.2.0'

# for API's needs.
gem 'pundit', '~> 0.3.0'
gem 'active_hash_relation'
gem 'active_model_serializers', '0.9.2'

gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'uglifier'

group :development, :test, :production do
  gem 'pg'
end

group :development, :test do
  gem 'faker'
  gem 'rubocop'
  gem 'pry'
end

group :test do
  gem 'rspec-rails'
  gem 'capybara'
  gem 'factory_girl_rails'
  gem 'database_cleaner', github: 'bmabey/database_cleaner'
  gem 'coveralls', require: false
end

group :production do
  gem 'unicorn'
end

gem 'sdoc', require: false
