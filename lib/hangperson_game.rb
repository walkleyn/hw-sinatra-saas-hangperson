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
    if guessed_word.nil? or guessed_word.empty? or guessed_word !~ /\w/
      raise ArgumentError
    end
    if guessed_word.downcase == @guesses or guessed_word.downcase == @wrong_guesses
      return false
    else
      if @word =~ /#{guessed_word}/
        @guesses += guessed_word
      else
        @wrong_guesses += guessed_word
      end
    end
  end

  def word_with_guesses
    display = []
    @word.each_char do |word_letter|
      if @guesses.include?(word_letter)
        @guesses.each_char do |guessed_letter|
        if guessed_letter == word_letter
            display << word_letter
          end
        end
      else
        display << '-'
      end
    end
    display.join
  end

  def check_win_or_lose
    score = word.size
    result = :lose if @wrong_guesses.size == 7
    @guesses.each_char do |guessed_letter|
      if @word.include?(guessed_letter)
        result = :play
        score -= 1
        if score == 0
          result = :win
        end
      else
        result = :lose
        exit
      end
    end
    result
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
