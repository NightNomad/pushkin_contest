class WelcomeController < ApplicationController

  def index
    render json: {'Greetings' => 'Welcome!'}
  end
end
