class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def guess(guessed_word)
#    p "Word is: #{@word}"
#    p "Guessed word is: #{guessed_word}"
#    p "Guesses is #{@guesses}"
#    p "Wrong guesses is: #{@wrong_guesses}"
    if guessed_word.nil? or guessed_word.empty? or guessed_word !~ /\w/
      raise ArgumentError
    end
    if guessed_word.downcase == @guesses or guessed_word.downcase == @wrong_guesses
      return false
    else
      if @word =~ /#{guessed_word}/
        @guesses = guessed_word
      else
        @wrong_guesses = guessed_word
      end
    end
  end

  def word_with_guesses
    p "Word = #{@word}"
    p "Guesses = #{@guesses}"
    @word.each_char do |letter|
      p "Letter = #{letter}"
      if letter == @guesses
        p "letter matches guess"
        display << letter
      else
        display << '-'
      end
    end
    display
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
