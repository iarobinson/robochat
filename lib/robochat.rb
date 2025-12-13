# frozen_string_literal: true

require_relative "robochat/version"
require "robochat/engine" if defined?(Rails)

module Robochat
  class Error < StandardError; end
  # Your code goes here...
  class << self
    attr_accessor :provider, :api_key, :model

    def self.configure
      yield self
    end
  end
end
