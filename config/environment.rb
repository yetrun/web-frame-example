# frozen_string_literal: true

require 'bundler/setup'
require 'pry' unless ENV['RACK_ENV'] == 'production'

ENV['RACK_ENV'] ||= 'development'
Bundler.require(:default, ENV['RACK_ENV'])

require 'meta/api'

require_relative 'initializers/i18n'
require_relative 'initializers/load_config'
require_relative 'initializers/autoload'
require_relative 'initializers/database'
require_relative 'initializers/application'
require_relative 'initializers/config_meta'
