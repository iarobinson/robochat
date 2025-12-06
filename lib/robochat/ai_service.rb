require "openai"

module Robochat
  class AiService
    def self.ask(prompt)
      raise "RoboChat API key not set!" unless Robochat.api_key

      client = OpenAI::Client.new(api_key: Robochat.api_key)
      response = client.chat(
        parameters: {
          model: Robochat.model || "gpt-4",
          messages: [{ role: "user", content: prompt }]
        }
      )

      response.dig("choices", 0, "message", "content")
    end
  end
end
