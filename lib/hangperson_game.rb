class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  attr_accessor :word, :guesses, :wrong_guesses

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def guess(letter)
    raise ArgumentError unless (letter =~ /^[a-zA-Z]$/)
    if @word =~ /#{letter}/i
      return false if @guesses =~ /#{letter}/i
      @guesses += letter
    else
      return false if @wrong_guesses =~ /#{letter}/i
      @wrong_guesses += letter
    end     
    true
  end

  def word_with_guesses
      @word.chars.map {|c| @guesses =~ /#{c}/ ? c : '-'}.join
  end

  def check_win_or_lose
    return :lose if @wrong_guesses.length >= 7
    return :win if word_with_guesses == word
    :play
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
