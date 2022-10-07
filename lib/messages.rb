# frozen_string_literal: true

# All messages outputted by application
class Messages
  def self.welcome_message
    'Welcome to Wordle.'
  end

  def self.rules
    <<~HELP
      Guess a five-letter word in 5 attempts. Each time you guess, you are told which of your chosen letters are in the target word, and whether they are in the right place.
      2 = this letter is in this position
      1 = this letter is in the target word but not this position
      0 = this letter is either not in the target word, or is not in the target
    HELP
  end

  def self.request_word(turn)
    "Please guess a 5 letter word (turn #{turn}):  "
  end

  def self.winning_message(text)
    "congratulations the target word was #{text}"
  end

  def self.out_of_lives
    'Sorry you ran out lives'
  end

  def self.incorrect_word_length(word_length)
    "Your guess was not #{word_length} letters long. Try again"
  end
end
