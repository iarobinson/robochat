require 'spec_helper'

RSpec.describe Robochat::Providers::Claude do
  let(:config) do
    Robochat::Configuration.new.tap do |c|
      c.claude_api_key = 'test-key'
      c.claude_model = 'claude-sonnet-4-20250514'
      c.claude_max_tokens = 1000
    end
  end
  let(:provider) { described_class.new(config) }

  describe '#name' do
    it 'returns :claude' do
      expect(provider.name).to eq(:claude)
    end
  end

  describe '#available?' do
    context 'when api key is present' do
      it 'returns true' do
        expect(provider.available?).to be true
      end
    end

    context 'when api key is nil' do
      before { config.claude_api_key = nil }

      it 'returns false' do
        expect(provider.available?).to be false
      end
    end

    context 'when api key is empty string' do
      before { config.claude_api_key = '' }

      it 'returns false' do
        expect(provider.available?).to be false
      end
    end
  end

  describe '#chat' do
    let(:message) { 'Hello' }

    context 'with successful API response' do
      before do
        stub_request(:post, "https://api.anthropic.com/v1/messages")
          .to_return(
            status: 200,
            body: {
              content: [{ text: 'Hello! How can I help?' }]
            }.to_json,
            headers: { 'Content-Type' => 'application/json' }
          )
      end

      it 'returns the response text' do
        expect(provider.chat(message)).to eq('Hello! How can I help?')
      end
    end

    context 'with API error' do
      before do
        stub_request(:post, "https://api.anthropic.com/v1/messages")
          .to_return(status: 401, body: 'Unauthorized')
      end

      it 'raises an error' do
        expect { provider.chat(message) }.to raise_error(/Claude API Error/)
      end
    end
  end
end