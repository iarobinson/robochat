Robochat.configure do |config|
  # Which providers to enable (defaults to [:claude])
  config.providers = [:claude]  # or [:claude, :openai] for both
  config.default_provider = :claude
  
  # Claude configuration
  config.claude_api_key = ENV['ANTHROPIC_API_KEY'] || Rails.application.credentials.dig(:anthropic, :api_key)
  config.claude_model = 'claude-sonnet-4-20250514'
  config.claude_max_tokens = 4000
  
  # OpenAI configuration (uncomment if using OpenAI)
  # config.openai_api_key = ENV['OPENAI_API_KEY'] || Rails.application.credentials.dig(:openai, :api_key)
  # config.openai_model = 'gpt-4'
  # config.openai_max_tokens = 4000
  
  # Shared settings
  config.temperature = 1.0
  config.system_prompt = "Robochat + AI assistant = ❤️"
end