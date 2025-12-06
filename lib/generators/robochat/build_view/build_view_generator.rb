module Robochat
  module Generators
    class BuildViewGenerator < Rails::Generators::Base
      source_root File.expand_path("templates", __dir__)

      def copy_chat_view
        template "chat.html.erb", "app/views/robochat/chats/index.html.erb"
      end
    end
  end
end
