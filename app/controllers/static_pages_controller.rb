require_relative '../../lib/state'
require_relative '../../lib/game'
require_relative '../../lib/messages'


class StaticPagesController < ApplicationController
  def home(params)
    game = Game.start

    loop do
      game.take_turn params[:guess]
    rescue Game::InvalidWord => e
      e
      return Messages.incorrect_word_length
    rescue Game::IncorrectWord => e
      outcome = e.outcome.each_with_index do |score, index|
        case score
        when 0
          red guess[index]
        when 1
          amber guess[index]
        when 2
          green guess[index]
        end
      end
      outcome.to_a.join ''
    ensure
      if game.finished?
        if game.won?
          return Messages.winning_message params[guess]
        end
        Messages.out_of_lives
      end
    end
  end  
end
