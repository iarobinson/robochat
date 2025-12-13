module Robochat
  module Generators
    class BuildViewGenerator < Rails::Generators::Base
      source_root File.expand_path("templates", __dir__)
      desc "Generates a RoboChat boilerplate chat view in your Rails app"

      def copy_chat_view
        template "chat.html.erb", "app/views/robochat/chats/index.html.erb"
      end
    end
  end
end
