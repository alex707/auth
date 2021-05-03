# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

gem 'rake'
gem 'puma'
gem 'sinatra', require: 'sinatra/base'
gem 'sinatra-contrib'
gem 'i18n'
gem 'config'
gem 'jwt', '~> 2.2.1'
gem 'pg', '~> 1.2.3'
gem 'sequel'
gem 'sequel_secure_password'
gem 'bunny'
gem 'dry-initializer'
gem 'dry-validation'

gem 'activesupport'
gem 'fast_jsonapi'

group :development, :test do
  gem 'rspec'
  gem 'factory_bot'
  gem 'rack-test'
  gem 'database_cleaner-sequel'
  gem 'sequel-seed'
end
