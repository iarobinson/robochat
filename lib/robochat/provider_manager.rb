module Robochat
  class ProviderManager
    def initialize(config)
      @config = config
      @providers = {}
      
      # Initialize enabled providers
      config.providers.each do |provider_name|
        provider_class = case provider_name
        when :claude then Providers::Claude
        when :openai then Providers::OpenAI
        else raise "Unknown provider: #{provider_name}"
        end
        
        provider = provider_class.new(config)
        @providers[provider_name] = provider if provider.available?
      end
    end
    
    def available_providers
      @providers.keys
    end
    
    def get_provider(name)
      @providers[name] || raise("Provider #{name} not available")
    end
    
    def default_provider
      @providers[@config.default_provider] || @providers.values.first
    end
  end
end