class State
    attr_reader :guesses, :target_word

    def initialize(target_word, guesses = [])
        @target_word = target_word
        @guesses = guesses
    end

    def won?
        @guesses.last == @target_word
    end

    def as_json(_options = {})
        { target_word: @target_word, guesses: @guesses }
    end
    
    def to_json(*_args)
        as_json.to_json
    end

    def self.from_json(json)
        json_state = JSON.parse json
        State.new json_state['target_word'], json_state['guesses']
    end
end
