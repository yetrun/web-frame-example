# frozen_string_literal: true

require 'bundler/setup'
require 'rack'

require_relative 'config/environment'

map '/api_spec' do
  use Rack::Cors do
    allow do
      origins '*'
      resource '*', headers: :any, methods: :get
    end
  end
  run ->(env) { API::Applications::Doc.call(env) }
end

use Rack::Cors do
  allow do
    origins '*'
    resource '*', headers: :any, methods: :any
  end
end
use OTR::ActiveRecord::ConnectionManagement
run ->(env) { API::Applications::Main.call(env) }
