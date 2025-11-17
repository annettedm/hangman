class Game
  MAX_ATTEMPTS_COUNT = 7
  attr_accessor :attempts_left, :non_existent_letters, :existent_letters, :round

  def initialize
    @attempts_left = MAX_ATTEMPTS_COUNT
    @non_existent_letters = []
    @existent_letters = []
    @winner_status = {}
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

  def manage_entry entry
    return if check_for_repeat_letter entry

    manage_letter(entry) if entry.length == 1
    manage_word(entry) if entry.length > 1
    check_template_for_fullness
  end

  def check_template_for_fullness
    if @word.template_full?
      change_winner_status("human")
    end
  end

  def manage_letter entry
    if @word.letter_exists? entry
      add_existent_letter entry
      puts word_template
    else
      manage_failed_attempt entry
    end
  end

  def change_winner_status winner
    @winner_status[:winner] = winner
    @winner_status[:word] = @word.word
    @winner_status
  end

  def manage_word entry
    if @word.word_match? entry
      change_winner_status('human')
    else
      manage_failed_attempt entry
    end
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

  def word_template
    @word.template_to_s
  end

  def add_existent_letter entry
    @existent_letters << entry
  end

  def show_word
    @word.word
  end
end
