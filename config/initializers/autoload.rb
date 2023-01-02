# frozen_string_literal: true

require 'zeitwerk'
require 'listen'
require 'pathname'

module API; end

loader = Zeitwerk::Loader.new
loader.tag = 'app'
loader.push_dir('app/api', namespace: API)
loader.push_dir('app/models')
loader.push_dir('app/entities')
if Settings.zeitwerk.auto_reloading
  loader.enable_reloading # you need to opt-in before setup

  Listen.to("app") { loader.reload }.start
end
loader.log! if Settings.zeitwerk.enable_logger
loader.setup # ready!
