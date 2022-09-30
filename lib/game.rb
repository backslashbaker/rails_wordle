require 'state'

class Game
    attr_accessor :state

    TARGET_WORDS = %w[About Alert Argue Beach Above Found Guess Doubt Every Frame Guest Dozen Exact Frank Guide Draft Exist Fraud Happy Drama Extra Fresh Harry Drawn Faith Front Heart Dream].freeze

    class InvalidWord < StandardError
    end

    class IncorrectWord < StandardError
        attr_reader :outcome

        def initialize(outcome)
            super
            @outcome = outcome
        end
    end

    def self.start(state = false)
        game = Game.new

        game.state = state ? State.from_json(state) : State.new(TARGET_WORDS.sample.downcase)
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
