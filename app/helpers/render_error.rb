# frozen_string_literal: true

module Helpers
  module RenderError
    class << self
      def render_parameter_invalid(execution, model)
        model_name = model.class.name.underscore
        errors = model.errors.messages
          .transform_values { |value| value[0] }
          .transform_keys { |key| "#{model_name}.#{key}"}

        execution.response.status = 400
        execution.response.body = [{
          code: 'parameters_invalid',
          message: '传递的部分参数不合法',
          details: errors
        }.to_json]
      end
    end
  end
end
