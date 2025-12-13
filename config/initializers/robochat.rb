# lib/robochat.rb
require "robochat/version"
require "robochat/engine"
require "httparty"

# Require providers
require "robochat/providers/base"
require "robochat/providers/claude"
require "robochat/providers/openai"
require "robochat/provider_manager"

module Robochat
  class Error < StandardError; end
  
  # Configuration class to hold settings
  class Configuration
    attr_accessor :providers, :default_provider
    
    # Claude settings
    attr_accessor :claude_api_key, :claude_model, :claude_max_tokens
    
    # OpenAI settings
    attr_accessor :openai_api_key, :openai_model, :openai_max_tokens
    
    # Shared settings (keep these from your original)
    attr_accessor :temperature, :system_prompt, :auth_method, :layout
    
    def initialize
      @providers = [:claude]  # Default to Claude only
      @default_provider = :claude
      
      # Claude defaults - try ENV first, then Rails credentials
      @claude_api_key = ENV['ANTHROPIC_API_KEY'] || 
                        (defined?(Rails) ? Rails.application.credentials.dig(:anthropic, :api_key) : nil)
      @claude_model = 'claude-sonnet-4-20250514'
      @claude_max_tokens = 4096
      
      # OpenAI defaults - try ENV first, then Rails credentials
      @openai_api_key = ENV['OPENAI_API_KEY'] || 
                        (defined?(Rails) ? Rails.application.credentials.dig(:openai, :api_key) : nil)
      @openai_model = 'gpt-4'
      @openai_max_tokens = 4096
      
      # Shared (from your original config)
      @temperature = 1.0
      @system_prompt = "Robochat + AI assistant = ❤️"
      @auth_method = :devise
      @layout = 'application'
    end
    
    # Backward compatibility methods (so old configs still work)
    def api_key
      @claude_api_key
    end
    
    def api_key=(value)
      @claude_api_key = value
    end
    
    def model
      @claude_model
    end
    
    def model=(value)
      @claude_model = value
    end
    
    def max_tokens
      @claude_max_tokens
    end
    
    def max_tokens=(value)
      @claude_max_tokens = value
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