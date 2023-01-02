# frozen_string_literal: true

module Helpers
  class ErrorLogger
    @padding = ' ' * 8

    def self.log_error(e)
      return unless e

      STDERR.puts "#{e.class}: #{e.message}"
      e.backtrace.each do |line|
        STDERR.puts @padding + line
      end
      log_error(e.cause)
    end
  end
end
