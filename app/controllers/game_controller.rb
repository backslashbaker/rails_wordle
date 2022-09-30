require 'game'
require 'messages'

class GameController < ApplicationController
  def guess
    @guess = params[:guess]
    crypt = ActiveSupport::MessageEncryptor.new Rails.application.config.state_secret
    if params[:state]
      @game = Game.start crypt.decrypt_and_verify @state
    else 
      @game = Game.start
    end
    @game.take_turn @guess
  rescue Game::InvalidWord
    @error = Messages.incorrect_word_length
  rescue Game::IncorrectWord => e
    @error = e

    # TODO:
      # Do not allow peiople to change state
  ensure 
    @state = crypt.encrypt_and_sign @game.state.to_json


  end

  def home
  end
end
