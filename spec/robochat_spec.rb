require 'spec_helper'

RSpec.describe Robochat do
  describe '.configure' do
    before do
      Robochat.reset_configuration!
    end

    it 'yields configuration object' do
      expect { |b| Robochat.configure(&b) }.to yield_with_args(Robochat::Configuration)
    end

    it 'allows setting configuration values' do
      Robochat.configure do |config|
        config.claude_api_key = 'test-key'
        config.temperature = 0.5
      end

      expect(Robochat.configuration.claude_api_key).to eq('test-key')
      expect(Robochat.configuration.temperature).to eq(0.5)
    end
  end

  describe '.configuration' do
    it 'returns configuration instance' do
      expect(Robochat.configuration).to be_a(Robochat::Configuration)
    end

    it 'returns same instance on multiple calls' do
      config1 = Robochat.configuration
      config2 = Robochat.configuration
      expect(config1).to be(config2)
    end
  end

  describe '.reset_configuration!' do
    it 'resets configuration to defaults' do
      Robochat.configure do |config|
        config.temperature = 0.5
      end

      Robochat.reset_configuration!
      expect(Robochat.configuration.temperature).to eq(1.0)
    end
  end
end