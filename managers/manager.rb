require_relative './game_serializer'
require_relative '../models/word'
require_relative '../models/game'
require_relative './game_loader'
require_relative '../modules/mappable'

class Manager
  include Mappable

  GAME_FLOW_CONTROLS = {
      stop_game: "stop",
      new_game: "new",
      save_game: 'save'
    }

  def initialize
    @game_loader = GameLoader.new
  end

  def start_app
    saved_game = @game_loader.run_saved_games

    start_game saved_game
  end

  private

  def start_game saved_game
    @word = Word.new
    @game = Game.new

    unless saved_game.nil?
      map_saved_game_to_game_word saved_game
    end

    game_start_instructions @game.attempts_left

    run_game
  end

  def run_game
    new_game = false

    while @game.attempts_left > 0 && !new_game
      puts "*****************************"
      @game.round += 1

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

  def game_start_instructions attempts
    puts "************************************************"
    puts "************************************************"
    puts "We play a Hangman game. A player guesses a word."
    puts "Each space in a word is for a letter. Once you guess a letter, it takes its place."
    puts "You have #{attempts} attempts to guess the word by letters. You can enter the whole word or only a letter."
    puts "If you enter a word and it matches the computer word, you win."
    puts "If a letter is not in the word, an attempt is utilized. Once #{attempts} attempts are over, a computer wins."
    puts "Enter '#{GAME_FLOW_CONTROLS[:new_game]}' to start a new game."
    puts "Enter '#{GAME_FLOW_CONTROLS[:stop_game]}' to stop the game."
    puts "Enter '#{GAME_FLOW_CONTROLS[:save_game]}' to save the game."
  end

  def round_instructions
      puts "Round #{@game.round}"
      puts "You have #{@game.attempts_left} attempts."
      p @game
      puts "Already used: #{@game.non_existent_letters.join(', ')}" if @game.non_existent_letters.length > 0
      puts @word.template_to_s

  end
end

# Manager
# - load game
# - save game
# - select saved games or start a new one

#   - A human player may save a game at any round.
#   - A human player may start one of the saved games with the word where they have left previous time.
#   - A human player may start a new game while playing a current one or once the game ends.
