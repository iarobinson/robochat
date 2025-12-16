module Robochat
  module ApplicationHelper
    def robochat_widget(options = {})
      provider = options[:provider] || Robochat.configuration.default_provider
      container_id = options[:container_id] || 'robochat-widget'
      
      content_tag(:div, id: container_id, class: 'robochat-widget-container') do
        content_tag(:iframe, '', 
          src: robochat_path,
          style: 'width: 100%; height: 600px; border: 1px solid #e0e0e0; border-radius: 8px;',
          **options.slice(:width, :height, :style)
        )
      end
    end
    
    def robochat_button(text = "Chat with AI", options = {})
      link_to text, robochat_path, 
        class: "robochat-button #{options[:class]}",
        target: options[:target] || '_blank',
        data: options[:data]
    end
  end
end