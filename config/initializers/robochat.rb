
Robochat.configure do |config|
  config.provider = :openai
  config.api_key = ENV["OPENAI_API_KEY"]
  config.model = "gpt-4o-mini"
end
