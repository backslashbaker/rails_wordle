# frozen_string_literal: true

class Words
  WORDS = {
    5 => %w[About Alert Argue Beach Above Found Guess Doubt Every Frame Guest Dozen Exact Frank Guide Draft Exist
            Fraud Happy Drama Extra Fresh Harry Drawn Faith Front Heart Dream],
    3 => %w[And	Fix	Own Are	Fly	Odd Ape	Fry	Our Ace	For	Pet Act	Got	Pat Ask	Get	Peg Arm	God	Paw Age	Gel	Pup Ago	Gas
            Pit Air	Hat	Put Ate	Hit	Pot All	Has	Pop But	Had	Pin Bye	How	Rat Bad	Her	Rag Big	His	Rub Bed	Hen	Row Bat	Ink	Rug Boy	Ice	Run Bus	Ill	Rap Bag	Jab	Ram Box	Jug	Sow],
    10 => %w[Agricolist Alienation Deputation Exultation Aborigines Feathering Likelihood Engraining Decumbency
             Employment Hydriodate]
  }.freeze

  def self.get(word_length = 5)
    counter = 0
    target_word = get_api(word_length)

    counter += 1 until counter <= 3 || use_regex(target_word)

    if use_regex(target_word)
      target_word
    else
      WORDS[word_length].sample.downcase
    end
  end

  def self.use_regex(input)
    regex = Regexp.new('^[a-z]+$', Regexp::IGNORECASE)
    regex.match input
  end

  def self.get_api(length)
    response = Excon.get("https://api.wordnik.com/v4/words.json/randomWord?hasDictionaryDef=true&maxCorpusCount=-1&minDictionaryCount=1&maxDictionaryCount=-1&minLength=#{length}&maxLength=#{length}&api_key=#{ENV['API_KEY']}")
    return nil if response.status != 200

    word = JSON.parse(response.body)
    word['word'].downcase
  end
end
