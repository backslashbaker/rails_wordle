class Words 
    WORDS = {
        5 => %w[About Alert Argue Beach Above Found Guess Doubt Every Frame Guest Dozen Exact Frank Guide Draft Exist Fraud Happy Drama Extra Fresh Harry Drawn Faith Front Heart Dream],
        3 => %w[And	Fix	Own Are	Fly	Odd Ape	Fry	Our Ace	For	Pet Act	Got	Pat Ask	Get	Peg Arm	God	Paw Age	Gel	Pup Ago	Gas	Pit Air	Hat	Put Ate	Hit	Pot All	Has	Pop But	Had	Pin Bye	How	Rat Bad	Her	Rag Big	His	Rub Bed	Hen	Row Bat	Ink	Rug Boy	Ice	Run Bus	Ill	Rap Bag	Jab	Ram Box	Jug	Sow],
        10 => %w[Agricolist Alienation Deputation Exultation Aborigines Feathering Likelihood Engraining Decumbency Employment Hydriodate]
    }.freeze

    def self.get(word_length = 5)
        WORDS[word_length].sample.downcase
    end
end