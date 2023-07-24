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

  Listen.to("app") {
    loader.reload

    if Settings.api_spec.websocket
      ws = Application.api_spec_ws
      puts "向客户端重新加载 API spec 的消息：#{ws}"
      ws&.send({ type: 'api_spec_reload' }.to_json)
    end
  }.start
end
loader.log! if Settings.zeitwerk.enable_logger
loader.setup # ready!
