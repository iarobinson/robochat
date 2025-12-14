require 'spec_helper'

RSpec.describe Robochat::Configuration do
  let(:config) { Robochat::Configuration.new }

  describe 'defaults' do
    it 'sets default providers to [:claude]' do
      expect(config.providers).to eq([:claude])
    end

    it 'sets default provider to :claude' do
      expect(config.default_provider).to eq(:claude)
    end

    it 'sets default claude model' do
      expect(config.claude_model).to eq('claude-sonnet-4-20250514')
    end

    it 'sets default openai model' do
      expect(config.openai_model).to eq('gpt-4')
    end

    it 'sets default temperature' do
      expect(config.temperature).to eq(1.0)
    end

    it 'sets default max tokens' do
      expect(config.claude_max_tokens).to eq(4096)
      expect(config.openai_max_tokens).to eq(4096)
    end
  end

  describe 'custom configuration' do
    it 'allows setting claude api key' do
      config.claude_api_key = 'test-key'
      expect(config.claude_api_key).to eq('test-key')
    end

    it 'allows setting multiple providers' do
      config.providers = [:claude, :openai]
      expect(config.providers).to eq([:claude, :openai])
    end

    it 'allows setting custom system prompt' do
      config.system_prompt = 'Custom prompt'
      expect(config.system_prompt).to eq('Custom prompt')
    end
  end
end