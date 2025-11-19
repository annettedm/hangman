require_relative '../modules/mappable'
require_relative './word'

class Game
  include Mappable

  MAX_ATTEMPTS_COUNT = 7
  attr_accessor :attempts, :non_existent_letters, :existent_letters, :round

  def initialize
    @attempts = MAX_ATTEMPTS_COUNT
    @non_existent_letters = []
    @existent_letters = []
    @round = 0
    @word = Word.new
  end

  def add_existent_letter entry
    @existent_letters << entry
  end

  def add_non_existent_letter letter
    @non_existent_letters << letter
  end

  def add_round
    @round += 1
  end

  def check_template_for_fullness
    return :human if @word.template_full?
  end

  def letter_used? entry
    @non_existent_letters.include?(entry) || @existent_letters.include?(entry)
  end

  def process_failed_attempt entry
    remove_attempt
    add_non_existent_letter entry
    puts "This entry does not exist for the word."
  end

  def process_entry entry
    return if try_process_repeat_letter(entry)

    if entry.length == 1
      process_letter(entry)
      check_template_for_fullness
    else
      process_word(entry)
    end
  end

  def process_letter entry
    if @word.letter_exists? entry
      add_existent_letter entry
    else
      process_failed_attempt entry
    end
  end

  def process_word entry
    if @word.word_match? entry
      return :human
    else
      process_failed_attempt entry
    end
  end

  def remove_attempt
    @attempts -= 1
  end

  def show_non_existent_letters
    @non_existent_letters.join(', ')
  end

  def show_word
    @word.word
  end

  def template
    @word.template_to_s
  end

  def try_process_repeat_letter entry
    if letter_used? entry
      puts "You have already used this entry."
      true
    end
  end
end
