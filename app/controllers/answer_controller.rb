class AnswerController < ApplicationController

respond_to :json

  def answer
    render json: { answer: 'снежные' }
  end
end
