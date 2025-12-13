# lib/robochat.rb
require "robochat/version"
require "robochat/engine"

module Robochat
  class Error < StandardError; end
  
  # Configuration class to hold settings
  class Configuration
    attr_accessor :api_key, :model, :max_tokens, :system_prompt, 
                  :auth_method, :layout, :temperature
    
    def initialize
      @api_key = ENV['ANTHROPIC_API_KEY']
      @model = 'claude-sonnet-4-20250514'
      @max_tokens = 4096
      @system_prompt = "Robochat + AI assistant = ❤️"
      @auth_method = :devise
      @layout = 'application'
      @temperature = 1.0
    end
  end
  
  class << self
    attr_writer :configuration
    
    # Returns the current configuration or creates a new one
    def configuration
      @configuration ||= Configuration.new
    end
    
    # Yields the configuration object to a block
    def configure
      yield(configuration)
    end
    
    # Reset configuration to defaults (useful for testing)
    def reset_configuration!
      @configuration = Configuration.new
    end
  end
end