# frozen_string_literal: true
# 
require "robochat/version"
require "robochat/engine"
require "httparty"

require "robochat/providers/base"
require "robochat/providers/claude"
require "robochat/providers/openai"
require "robochat/provider_manager"

module Robochat
  class Error < StandardError; end

  class Configuration
    attr_accessor :providers, :default_provider
    
    # Claude settings
    attr_accessor :claude_api_key, :claude_model, :claude_max_tokens
    
    # OpenAI settings
    attr_accessor :openai_api_key, :openai_model, :openai_max_tokens
    
    # Shared settings
    attr_accessor :temperature, :system_prompt
    
    def initialize
      @providers = [:claude]
      @default_provider = :claude
      
      @claude_api_key = ENV['ANTHROPIC_API_KEY'] || 
                    (defined?(Rails) && Rails.application ? Rails.application.credentials.dig(:anthropic, :api_key) : nil)
      @claude_model = 'claude-sonnet-4-20250514'
      @claude_max_tokens = 4096
      
      @openai_api_key = ENV['OPENAI_API_KEY'] || 
                    (defined?(Rails) && Rails.application ? Rails.application.credentials.dig(:openai, :api_key) : nil)
      @openai_model = 'gpt-4'
      @openai_max_tokens = 4096
      
      @temperature = 1.0
      @system_prompt = "You are a helpful AI assistant."
    end
  end

  class << self
    attr_writer :configuration
    
    def configuration
      @configuration ||= Configuration.new
    end
    
    def configure
      yield(configuration)
    end
    
    def reset_configuration!
      @configuration = Configuration.new
    end
  end
end