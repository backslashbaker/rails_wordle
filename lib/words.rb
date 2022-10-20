class Words 
    
    def self.get(word_length = 5)
        response = Excon.get("https://api.wordnik.com/v4/words.json/randomWord?hasDictionaryDef=true&maxCorpusCount=-1&minDictionaryCount=1&maxDictionaryCount=-1&minLength=#{word_length}&maxLength=#{word_length}&api_key=#{ENV['API_KEY']}")
        return nil if response.status != 200

        word = JSON.parse(response.body)
        word["word"].downcase
    end
end
