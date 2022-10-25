class Words 
    
        WORDS = {
        5 => %w[About Alert Argue Beach Above Found Guess Doubt Every Frame Guest Dozen Exact Frank Guide Draft Exist Fraud Happy Drama Extra Fresh Harry Drawn Faith Front Heart Dream],
        3 => %w[And	Fix	Own Are	Fly	Odd Ape	Fry	Our Ace	For	Pet Act	Got	Pat Ask	Get	Peg Arm	God	Paw Age	Gel	Pup Ago	Gas	Pit Air	Hat	Put Ate	Hit	Pot All	Has	Pop But	Had	Pin Bye	How	Rat Bad	Her	Rag Big	His	Rub Bed	Hen	Row Bat	Ink	Rug Boy	Ice	Run Bus	Ill	Rap Bag	Jab	Ram Box	Jug	Sow],
        10 => %w[Agricolist Alienation Deputation Exultation Aborigines Feathering Likelihood Engraining Decumbency Employment Hydriodate]
    }.freeze
    

    
    def self.get(word_length = 5)
        counter = 0
        target_word = get_api(word_length)

        until counter <= 3 || use_regex(word) do
            counter = counter + 1
        end
        
        if counter == 3 
            WORDS[word_length].sample.downcase
        else
            target_word 
        end
    end


    private

    def self.use_regex(input)
        regex = Regexp.new('[a-zA-Z]+', Regexp::IGNORECASE)
        regex.match input
    end

    def self.get_api(length)
        response = Excon.get("https://api.wordnik.com/v4/words.json/randomWord?hasDictionaryDef=true&maxCorpusCount=-1&minDictionaryCount=1&maxDictionaryCount=-1&minLength=#{length}&maxLength=#{length}&api_key=#{ENV['API_KEY']}")
            return nil if response.status != 200
            word = JSON.parse(response.body)
            target_word = word["word"].downcase
            target_word
    end


    


end
