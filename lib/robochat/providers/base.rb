module Robochat
  module Providers
    class Base
      def initialize(config)
        @config = config
      end
      
      def chat(message)
        raise NotImplementedError, "Subclass must implement chat method"
      end
      
      def name
        raise NotImplementedError, "Subclass must implement name method"
      end
      
      def available?
        raise NotImplementedError, "Subclass must implement available? method"
      end
    end
  end
end