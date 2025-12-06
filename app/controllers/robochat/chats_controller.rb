module Robochat
  class ChatsController < ApplicationController
    def index
      # Boilerplate view
    end

    def ask
      question = params[:question]
      answer = Robochat::AiService.ask(question)
      render json: { answer: answer }
    end
  end
end
