require 'spec_helper'

RSpec.describe Robochat::Providers::Base do
  let(:config) { Robochat::Configuration.new }
  let(:provider) { described_class.new(config) }

  describe '#chat' do
    it 'raises NotImplementedError' do
      expect { provider.chat('test') }.to raise_error(NotImplementedError)
    end
  end

  describe '#name' do
    it 'raises NotImplementedError' do
      expect { provider.name }.to raise_error(NotImplementedError)
    end
  end

  describe '#available?' do
    it 'raises NotImplementedError' do
      expect { provider.available? }.to raise_error(NotImplementedError)
    end
  end
end