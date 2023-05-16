# frozen_string_literal: true

require 'bundler/setup'
require 'rack/test'
require 'database_cleaner/active_record'
require 'factory_bot'

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  config.include(Rack::Test::Methods)

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)

    FactoryBot.find_definitions
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end

RSpec::Matchers.define :has_status do |expected_status|
  match do |response|
    response.status == expected_status
  end
  failure_message do |response|
    "期望返回状态码 #{expected_status}，实际返回状态码 #{response.status}. [response.body=#{response.body}]"
  end
end

module AppSpec
  def app
    API::Applications::Main
  end
end

# 引入项目环境
ENV['RACK_ENV'] = ENV['RACK_ENV'] || 'test'
require_relative '../config/environment'
I18n.locale = :'zh-CN'
