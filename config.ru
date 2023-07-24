# frozen_string_literal: true

require 'bundler/setup'
require 'rack'
require_relative 'lib/middlewares/set_i18n_locale'

require_relative 'config/environment'

map '/api_spec' do
  use Rack::Cors do
    allow do
      origins '*'
      resource '*', headers: :any, methods: :get
    end
  end
  use API::Applications::Doc::WebSocketConnection
  run ->(env) { API::Applications::Doc.call(env) }
end

# 这里的 use 不能与 map '/api_spec' 中的共享
use Rack::Cors do
  allow do
    origins '*'
    resource '*', headers: :any, methods: :any
  end
end
use SetI18nLocale, :'zh-CN'
use OTR::ActiveRecord::ConnectionManagement

run ->(env) { API::Applications::Main.call(env) }
