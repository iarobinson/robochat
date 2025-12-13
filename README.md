# Robochat

As of December 2025, this adds Claude AI chat to your Rails application.

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

1. **Set your API key:**

### For Anthropic

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

## Configuration Options
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