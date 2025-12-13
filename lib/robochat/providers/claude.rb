module Robochat
  module Providers
    class Claude < Base
      def name
        :claude
      end
      
      def available?
        @config.claude_api_key.present?
      end
      
      def chat(message)
        response = HTTParty.post(
          'https://api.anthropic.com/v1/messages',
          headers: {
            'Content-Type' => 'application/json',
            'x-api-key' => @config.claude_api_key,
            'anthropic-version' => '2023-06-01'
          },
          body: {
            model: @config.claude_model,
            max_tokens: @config.claude_max_tokens,
            temperature: @config.temperature,
            system: @config.system_prompt,
            messages: [{ role: 'user', content: message }]
          }.to_json
        )
        
        if response.success?
          response.dig('content', 0, 'text') || 'No response received'
        else
          raise "Claude API Error: #{response.code} - #{response.message}"
        end
      end
    end
  end
end