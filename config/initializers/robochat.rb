
Robochat.configure do |config|
  config.api_key = ENV["OPENAI_API_KEY"]
  config.model   = "gpt-4"
end
