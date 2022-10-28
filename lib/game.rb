# frozen_string_literal: true

require 'state'
require 'words'

class Game
  attr_accessor :state

  DIFFICULTIES = {
    hard: 10,
    medium: 5,
    easy: 3
  }.freeze

  class InvalidWord < StandardError
  end

  class IncorrectWord < StandardError
    attr_reader :outcome

    def initialize(outcome)
      super
      @outcome = outcome
    end
  end

  def self.start(difficulty = :medium)
    game = Game.new

    game.state = State.new Words.get DIFFICULTIES[difficulty]
    game
  end

  def self.resume(state)
    game = Game.new

    game.state = State.from_json state
    game
  end

  def take_turn(guess)
    raise InvalidWord unless valid? guess

    @state.guesses << guess
    raise IncorrectWord, check_guess(guess, @state.target_word) unless @state.won?
  end

  def finished?
    @state.won? || @state.guesses.length >= 5
  end

  def won?
    @state.won?
  end

  def turn
    @state.guesses.length + 1
  end

  private

  def check_guess(guess, target)
    guess_letters = guess.split('')
    target_letters = target.split('')
    guess_letters.each_with_index.map do |letter, index|
      correct_letter_and_position = target_letters.include?(letter) && letter == target_letters[index]
      correct_letter_wrong_position = target_letters.include?(letter) && letter != target_letters[index]

      if correct_letter_and_position
        2
      else
        correct_letter_wrong_position ? 1 : 0
      end
    end
  end

  def valid?(guess)
    guess.length == @state.target_word.length
  end
end
