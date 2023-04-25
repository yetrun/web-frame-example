# frozen_string_literal: true

require 'bundler/setup'
# Ruby 3.2 版本引入 'pry' 会报错：
#
#     NameError:
#       undefined method `=~' for class `Pry::Code'
require 'pry' if ENV['RACK_ENV'] != 'production' && Gem::Version.new(RUBY_VERSION) < '3.2'

ENV['RACK_ENV'] ||= 'development'
Bundler.require(:default, ENV['RACK_ENV'])

require 'meta/api'

require_relative 'initializers/i18n'
require_relative 'initializers/load_config'
require_relative 'initializers/autoload'
require_relative 'initializers/database'
require_relative 'initializers/application'
require_relative 'initializers/config_meta'
