class Game
  MAX_ATTEMPTS_COUNT = 7
  attr_accessor :attempts_left, :non_existent_letters, :existent_letters, :round

  def initialize
    @attempts_left = MAX_ATTEMPTS_COUNT
    @non_existent_letters = []
    @existent_letters = []
    @round = 0
  end

  def remove_attempt
    @attempts_left -= 1
  end

  def add_non_existent_letter letter
    @non_existent_letters << letter
  end

  def show_non_existent_letters
    @non_existent_letters.join(', ')
  end

  def check_for_repeat_letter entry
    if letter_used? entry
      puts "You have already used this entry."
      true
    end
  end

  def letter_used? entry
    @non_existent_letters.include?(entry) || @existent_letters.include?(entry)
  end

  def manage_failed_attempt entry
    remove_attempt
    add_non_existent_letter entry
  end

  def add_existent_letter entry
    @existent_letters << entry
  end

  def show_word
    @word.word
  end
end
