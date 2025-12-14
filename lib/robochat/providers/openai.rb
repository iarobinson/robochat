module Robochat
  module Providers
    class OpenAI < Base
      def name
        :openai
      end
      
      def available?
        @config.openai_api_key.present?
      end
      
      def chat(message)
        response = HTTParty.post(
          'https://api.openai.com/v1/chat/completions',
          headers: {
            'Content-Type' => 'application/json',
            'Authorization' => "Bearer #{@config.openai_api_key}"
          },
          body: {
            model: @config.openai_model,
            max_tokens: @config.openai_max_tokens,
            temperature: @config.temperature,
            messages: [
              { role: 'system', content: @config.system_prompt },
              { role: 'user', content: message }
            ]
          }.to_json
        )
        
        if response.success?
          response.dig('choices', 0, 'message', 'content') || 'No response received'
        else
          raise "OpenAI API Error: #{response.code} - #{response.message}"
        end
      end
    end
  end
end