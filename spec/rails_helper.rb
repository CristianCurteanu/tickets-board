# frozen_string_literal: true

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'shoulda'
require 'airborne'
require 'faker'
require 'database_cleaner'
require 'model_generators'
require 'user_mock_helper'

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = true

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

  # config.include RSpec::Rails::RequestExampleGroup, type: :request, file_path: /spec\/resources\/api/
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.include ModelGenerators
  config.include UserMockHelper
end

Airborne.configure do |c|
  # c.base_url = 'http://example.com/'
end
