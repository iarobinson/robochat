# Robochat
[![Gem Version](https://badge.fury.io/rb/robochat.svg)](https://badge.fury.io/rb/robochat)
[![Build Status](https://github.com/iarobinson/robochat/workflows/CI/badge.svg)](https://github.com/iarobinson/robochat/actions)

Add AI chat to your Rails application with support for multiple LLM providers.

### What it does:

- Rails Engine with a clean chat interface (vanilla CSS)
- **Multi-provider support**: Claude (Anthropic) and OpenAI (ChatGPT)
- Switch between providers with a dropdown or configure specific routes
- Simple configuration system
- No database required
- Request/response chat (stateless)

### What it doesn't do yet:

- No conversation persistence (each message is standalone)
- No user authentication hooks
- No streaming responses
- No file uploads
- No conversation history UI
- No customization options for styling
- No helper methods for embedding chat in other views

## Installation

Add robochat to your Gemfile:
```ruby
gem 'robochat'
```

Then bundle:
```bash
bundle install
```

## Quick Start

### Single Provider (Claude)

1. **Set your API key:**
```bash
# Set environment variable
export ANTHROPIC_API_KEY='sk-ant-...'

# Or use Rails credentials
rails credentials:edit
# Add: anthropic: { api_key: sk-ant-... }
```

2. **Create initializer:**
```ruby
# config/initializers/robochat.rb
Robochat.configure do |config|
  config.providers = [:claude]
  config.claude_api_key = ENV['ANTHROPIC_API_KEY']
  config.claude_model = 'claude-sonnet-4-20250514'
  config.claude_max_tokens = 4096
end
```

3. **Mount the engine:**
```ruby
# config/routes.rb
Rails.application.routes.draw do
  mount Robochat::Engine => '/chat'
end
```

4. **Start chatting!**

Visit `http://localhost:3000/chat` and start chatting with Claude!

### Single Provider (OpenAI)

1. **Set your API key:**
```bash
# Set environment variable
export OPENAI_API_KEY='sk-...'

# Or use Rails credentials
rails credentials:edit
# Add: openai: { api_key: sk-... }
```

2. **Create initializer:**
```ruby
# config/initializers/robochat.rb
Robochat.configure do |config|
  config.providers = [:openai]
  config.openai_api_key = ENV['OPENAI_API_KEY']
  config.openai_model = 'gpt-4'
  config.openai_max_tokens = 4096
end
```

3. **Mount and chat** (same as Claude setup above)

### Multiple Providers

Enable both Claude and OpenAI with a dropdown selector:
```ruby
# config/initializers/robochat.rb
Robochat.configure do |config|
  config.providers = [:claude, :openai]
  config.default_provider = :claude
  
  # Claude config
  config.claude_api_key = ENV['ANTHROPIC_API_KEY']
  config.claude_model = 'claude-sonnet-4-20250514'
  config.claude_max_tokens = 4096
  
  # OpenAI config
  config.openai_api_key = ENV['OPENAI_API_KEY']
  config.openai_model = 'gpt-4'
  config.openai_max_tokens = 4096
  
  # Shared settings
  config.temperature = 1.0
  config.system_prompt = "You are a helpful AI assistant."
end
```

The chat UI will show a dropdown to switch between providers.

### Custom Routes

You can create custom routes for specific providers:
```ruby
# config/routes.rb
Rails.application.routes.draw do
  # Main chat with all providers
  mount Robochat::Engine => '/chat'
  
  # Custom provider-specific routes
  get '/claude-assistant', to: 'robochat/messages#claude'
  get '/gpt-helper', to: 'robochat/messages#openai'
  
  root 'robochat/messages#index'
end
```

## Configuration Options

### Claude Settings
```ruby
config.claude_api_key      # Your Anthropic API key
config.claude_model        # Default: 'claude-sonnet-4-20250514'
config.claude_max_tokens   # Default: 4096
```

### OpenAI Settings
```ruby
config.openai_api_key      # Your OpenAI API key
config.openai_model        # Default: 'gpt-4'
config.openai_max_tokens   # Default: 4096
```

### Shared Settings
```ruby
config.providers           # Array of enabled providers, e.g. [:claude, :openai]
config.default_provider    # Which provider to use by default
config.temperature         # Response creativity (0.0-2.0), default: 1.0
config.system_prompt       # Custom system prompt for all providers
```

## Requirements

- Ruby >= 3.0
- Rails >= 7.0
- API keys:
  - Anthropic ([get one here](https://console.anthropic.com/))
  - OpenAI ([get one here](https://platform.openai.com/api-keys))

## Roadmap

Future provider support planned:
- Grok (xAI)
- Perplexity
- Google Gemini
- Mistral

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/iarobinson/robochat

## License

MIT License - see LICENSE.txt for details