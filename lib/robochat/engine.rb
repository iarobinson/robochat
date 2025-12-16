module Robochat
  class Engine < ::Rails::Engine
    isolate_namespace Robochat
    
    # Make helpers available to host application
    config.to_prepare do
      ApplicationController.helper(Robochat::ApplicationHelper)
    end
  end
end