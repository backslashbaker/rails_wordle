# frozen_string_literal: true

require 'game'
require 'messages'

class GameController < ApplicationController
  class StatePersistence
    def self.encrypt(message)
      crypt = ActiveSupport::MessageEncryptor.new Rails.application.config.state_secret
      crypt.encrypt_and_sign message
    end

    def self.decrypt(message)
      crypt = ActiveSupport::MessageEncryptor.new Rails.application.config.state_secret
      crypt.decrypt_and_verify message
    end
  end

  def guess
    @guess = params[:guess].downcase

    @game = Game.resume StatePersistence.decrypt params[:state]
    @game.take_turn @guess
  rescue Game::InvalidWord
    @error = Messages.incorrect_word_length(@game.state.target_word.length)
  rescue Game::IncorrectWord => e
    @error = e
  ensure
    @state = StatePersistence.encrypt @game.state.to_json

    render :game
  end

  def home; end

  def start
    @game = Game.start(params[:difficulty].downcase.to_sym)
    @state = StatePersistence.encrypt(@game.state.to_json)
    render :game
  end
end
