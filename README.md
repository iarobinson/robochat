# Robochat
[![Gem Version](https://badge.fury.io/rb/robochat.svg)](https://badge.fury.io/rb/robochat)
[![Build Status](https://github.com/iarobinson/robochat/workflows/CI/badge.svg)](https://github.com/iarobinson/robochat/actions)

As of December 2025, this adds Claude AI chat to your Rails application.

### What it does:

- Provides a Rails Engine that mounts a chat interface
- Single-page chat UI with Claude-like styling (vanilla CSS)
- Makes API calls to Anthropic's Claude
- Configuration system for API key, model, max_tokens, etc.
- Simple request/response (no conversation history)
- No database required

### What it doesn't do yet:

- No conversation persistence (each message is standalone)
- No user authentication hooks
- No streaming responses
- No file uploads
- No conversation history UI
- No customization options for styling
- No helper methods for embedding chat in other views

The goal will to make adding various different LLMs to a single application with a single gem.

## Installation

Add robochat to your Gemfile:

```ruby
gem 'robochat'
```

Then budle:
```bash
bundle install
```

## Quick Start

### For Anthropic

1. **Set your API key:**

```bash
# Set environment variable
export ANTHROPIC_API_KEY='your-key-here'

# Or use Rails credentials
rails credentials:edit
# Add: anthropic: { api_key: your-key-here }
```

2. **Create initializer:**
```ruby
# config/initializers/robochat.rb
Robochat.configure do |config|
  config.api_key = ENV['ANTHROPIC_API_KEY']
  config.model = 'claude-sonnet-4-20250514'
  config.max_tokens = 4096
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

#### Configuration Options
```ruby
Robochat.configure do |config|
  config.api_key = ENV['ANTHROPIC_API_KEY']     # Required
  config.model = 'claude-sonnet-4-20250514'     # Default model
  config.max_tokens = 4096                       # Max response length
  config.temperature = 1.0                       # Response creativity
  config.system_prompt = "You are helpful..."    # Custom system prompt
end
```

### For ChatGPT

(coming soon)

### For Grok

(coming soon)

### For Perplexity

(coming soon)

## Requirements

- Ruby >= 3.0
- Rails >= 7.0
- Anthropic API key ([get one here](https://console.anthropic.com/))

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/iarobinson/robochat

## License

MIT License - see LICENSE.txt for details