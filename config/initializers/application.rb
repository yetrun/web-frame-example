# frozen_string_literal: true

module Application
  @root = Pathname.new(__dir__).join('../..').realpath.to_s
  @env = ENV['RACK_ENV'] ||= 'development'

  class << self
    attr_reader :root, :env
  end
end
