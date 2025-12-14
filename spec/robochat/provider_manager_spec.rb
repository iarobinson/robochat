require 'spec_helper'

RSpec.describe Robochat::ProviderManager do
  let(:config) do
    Robochat::Configuration.new.tap do |c|
      c.providers = [:claude, :openai]
      c.default_provider = :claude
      c.claude_api_key = 'claude-key'
      c.openai_api_key = 'openai-key'
    end
  end
  let(:manager) { described_class.new(config) }

  describe '#available_providers' do
    it 'returns array of available provider names' do
      expect(manager.available_providers).to contain_exactly(:claude, :openai)
    end

    context 'when only one provider has api key' do
      before { config.openai_api_key = nil }
      let(:manager) { described_class.new(config) }

      it 'returns only available providers' do
        expect(manager.available_providers).to eq([:claude])
      end
    end
  end

  describe '#get_provider' do
    it 'returns claude provider' do
      provider = manager.get_provider(:claude)
      expect(provider).to be_a(Robochat::Providers::Claude)
    end

    it 'returns openai provider' do
      provider = manager.get_provider(:openai)
      expect(provider).to be_a(Robochat::Providers::OpenAI)
    end

    it 'raises error for unknown provider' do
      expect { manager.get_provider(:unknown) }.to raise_error(/not available/)
    end
  end

  describe '#default_provider' do
    it 'returns the configured default provider' do
      provider = manager.default_provider
      expect(provider).to be_a(Robochat::Providers::Claude)
    end

    context 'when default provider is not available' do
      before do
        config.default_provider = :openai
        config.openai_api_key = nil
      end
      let(:manager) { described_class.new(config) }

      it 'returns first available provider' do
        provider = manager.default_provider
        expect(provider).to be_a(Robochat::Providers::Claude)
      end
    end
  end

  describe 'unknown provider' do
    it 'raises error for unknown provider name' do
      config.providers = [:unknown]
      expect { described_class.new(config) }.to raise_error(/Unknown provider/)
    end
  end
end