class State
    attr_reader :guesses, :target_word

    def initialize(target_word, guesses = [])
        @target_word = target_word
        @guesses = guesses
    end

    def won?
        @guesses.last == @target_word
    end
end
