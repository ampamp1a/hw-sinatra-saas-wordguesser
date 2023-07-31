class WordGuesserGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  # Get a word from remote "random word" service

  def initialize(word)
    @word = word
    @guesses = ""
    @wrong_guesses = ""
  end

  attr_accessor :word,:guesses,:wrong_guesses
  
  def guess(letter)
    raise ArgumentError, "Input cannot be empty." if letter.nil? || letter.empty?
    raise ArgumentError, "Input must be a single letter." unless letter.match?(/[A-Za-z]/)

    letter.downcase!
    if @word.include?(letter) and not @guesses.include?(letter)
      @guesses = @guesses + letter
      return true

    elsif not @word.include?(letter) and not @wrong_guesses.include?(letter)
        @wrong_guesses = @wrong_guesses + letter
        return true
    end

    return false
  end

  def word_with_guesses
    display = @word.chars.map { |letter| @guesses.include?(letter) ? letter : '-' }
    display.join('')
  end

  def check_win_or_lose
    if @word.chars.all? { |char| @guesses.include?(char) }
      :win
    elsif @wrong_guesses.size >= 7
      :lose
    else
      :play
    end
  end

  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start { |http|
      return http.post(uri, "").body
    }
  end

end
