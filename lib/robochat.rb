# frozen_string_literal: true

require_relative "robochat/version"
require "robochat/engine" if defined?(Rails)

module Robochat
  class Error < StandardError; end
  # Your code goes here...
  class << self
    attr_accessor :api_key, :model

    def configure
      yield self
    end
  end
end
