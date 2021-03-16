# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

gem 'rake'
gem 'puma'
gem 'sinatra', require: 'sinatra/base'
gem 'sinatra-contrib'
gem 'i18n'
gem 'config'
gem 'pg', '~> 1.2.3'
gem 'sequel'
gem 'dry-initializer'
gem 'dry-validation'

gem 'fast_jsonapi'

gem 'sequel_secure_password'

group :development, :test do
  gem 'rspec'
  gem 'factory_bot'
  gem 'rack-test'
  gem 'database_cleaner-sequel'
end
