# frozen_string_literal: true

require_relative '../../helpers/render_error'
require_relative '../../helpers/log_error'

module API
  module Applications
    class Main < Meta::Application
      rescue_error Meta::Errors::ParameterInvalid do |e|
        error_entity = {
          code: 'parameters_invalid',
          message: '传递的部分参数不合法',
          details: e.errors
        }

        response.status = 400
        response.body = [JSON.generate(error_entity)]
      end

      rescue_error ActiveRecord::RecordInvalid do |e|
        Helpers::RenderError.render_parameter_invalid(self, e.record)
      end

      rescue_error Meta::Errors::NoMatchingRoute do |e|
        error_entity = {
          code: 'no_matching_route',
          message: e.message
        }

        response.status = 404
        response.body = [JSON.generate(error_entity)]
      end

      rescue_error Meta::Errors::UnsupportedContentType do |e|
        error_entity = {
          code: 'unsupported_content_type',
          message: e.message
        }

        response.status = 400
        response.body = [JSON.generate(error_entity)]
      end

      rescue_error StandardError do |e|
        error_entity = {
          code: 'server_error',
          message: '服务器发生了未知异常'
        }
        response.status = 500
        response.body = [JSON.generate(error_entity)]

        Helpers::ErrorLogger.log_error(e)
      end if Application.env != 'test'

      get '/' do
        title '应用根路由'
        action do
          response.body = ['Web API 示例项目']
        end
      end

      apply API::Articles, tags: ['Article']
    end
  end
end