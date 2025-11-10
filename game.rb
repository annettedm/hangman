require_relative './word'

class Game
  MAX_ATTEMPTS_COUNT = 7
  attr_reader :attempts_left, :non_existent_letters

  def initialize
    @attempts_left = MAX_ATTEMPTS_COUNT
    @non_existent_letters = []
    @existing_letters = []
    @word = Word.new
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

  def manage_entry entry
    if letter_used? entry
        puts "You have already used this entry."
        return
    end


    if entry.length > 1
      if @word.check_word entry
        human_win
      else
        manage_failed_attempt entry
      end
    else
      if @word.check_letter entry
        add_existing_letter entry
        word_template
      else
        manage_failed_attempt entry
      end
    end
    if @word.template_full?
      human_win
    end
  end

  def letter_used? entry
    @non_existent_letters.include?(entry) || @existing_letters.include?(entry)
  end

  def human_win
    puts "You win! The word you guess is '#{@word.word}'."
    exit
  end

  def manage_failed_attempt entry
    remove_attempt
    add_non_existent_letter entry
  end

  def word_template
    @word.template
  end

  def add_existing_letter entry
    @existing_letters << entry
  end

  def show_word
    puts "#{@word.word}"
  end
end
