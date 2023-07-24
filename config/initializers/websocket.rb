# frozen_string_literal: true

# 开发环境下的 Rack::Lint 会干扰到 Faye::WebSocket 功能，需要在 WebSocket 环境下禁用它
#
# > 参考资料：https://gist.github.com/shtirlic/2146256
module Rack
  class Lint
    alias :original_call :call

    def call(env = nil)
      if Faye::WebSocket.websocket?(env)
        @app.call(env)
      else
        original_call(env)
      end
    end
  end
end

module API
  module Applications
    class Doc::WebSocketConnection
      def initialize(app)
        @app = app
      end

      def call(env)
        if Faye::WebSocket.websocket?(env)
          ws = Faye::WebSocket.new(env)
          puts "存储 WebSocket 连接：#{ws}"
          Application.api_spec_ws = ws

          ws.on :open do |event|
            puts "WebSocket opened"

            spec_url = URI.join("http://localhost:9292", env['REQUEST_PATH']).to_s
            payload = { type: 'api_spec_load', url: spec_url }.to_json
            ws.send(payload)
            puts "WebSocket sent: #{payload}"
          end

          ws.on :close do |event|
            puts "WebSocket closed"
            Application.api_spec_ws = nil if Application.api_spec_ws == ws
          end

          # Return async Rack response
          ws.rack_response
        else
          @app.call(env)
        end
      end
    end
  end
end

module Application
  class << self
    attr_reader :api_spec_ws

    def api_spec_ws=(ws)
      @api_spec_ws.close if @api_spec_ws&.ready_state == Faye::WebSocket::API::OPEN
      @api_spec_ws = ws
    end
  end
end
