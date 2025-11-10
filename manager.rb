require_relative './word'
require_relative './game'
require_relative './game_state'

class Manager
  GAME_FLOW_CONTROLS = {
    stop_game: "stop",
    new_game: "new"
  }
  def initialize
    @game = Game.new
    @round = 0
  end

  def start_game
    game_start_instructions

    run_game
  end

  def run_game
    new_game = false

    while @game.attempts_left > 0 && !new_game
      puts "*****************************"
      @round += 1

      round_instructions
      # @game.show_word
      entry = get_entry

      if GAME_FLOW_CONTROLS.values.include? entry
        new_game = manage_game_control entry
      else
        winner_status = @game.manage_entry(entry)

        manage_winner_status(winner_status) if winner_status
      end

    end

    if new_game
      {new_game: true}
    else
      puts "The game is over. A computer wins. The word is #{@game.show_word}."
    end
  end

  private

  def manage_game_control entry
    if GAME_FLOW_CONTROLS[:stop_game] == entry
      exit
    end
    if GAME_FLOW_CONTROLS[:new_game] == entry
      true
    end
  end

  def manage_winner_status status
    if status[:winner] == "human"
      puts "You win."
    elsif status[:winner] == "computer"
      puts "Computer wins as attempts are over."
    end
    puts "The word is '#{status[:word]}'."
    exit
  end

  def game_start_instructions
    puts "************************************************"
    puts "************************************************"
    puts "We play a Hangman game. A player guesses a word."
    puts "Each space in a word is for a letter. Once you guess a letter, it takes its place."
    puts "You have 7 attempts to guess the word by letters. You can enter the whole word or only a letter."
    puts "If you enter a word and it matches the computer word, you win."
    puts "If a letter is not in the word, an attempt is utilized. Once 7 attempts are over, a computer wins."
    puts "Enter '#{GAME_FLOW_CONTROLS[:new_game]}' to start a new game."
    puts "Enter '#{GAME_FLOW_CONTROLS[:stop_game]}' to stop the game."
  end

  def round_instructions
    puts "Round #{@round}"
    puts "You have #{@game.attempts_left} attempts."
    puts "Already used: #{@game.non_existent_letters.join(', ')}" if @game.non_existent_letters.length > 0
    puts word_template
  end

  def word_template
    @game.word_template
  end

  def get_entry
    entry = gets.chomp.downcase

    while !alphabetic? entry
      puts "Please, enter letters only."
      entry = gets.chomp.downcase
    end

    entry
  end

  def alphabetic? value
    value.match?(/\A[a-zA-Z]+\z/)
  end
end

# Manager
# - load game
# - save game
# - select saved games or start a new one

#   - A human player may save a game at any round.
#   - A human player may start one of the saved games with the word where they have left previous time.
#   - A human player may start a new game while playing a current one or once the game ends.
