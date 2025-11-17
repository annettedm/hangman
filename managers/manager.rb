require_relative './game_serializer'
require_relative './models/word'
require_relative './game_loader'

class Manager

  def initialize
    @game_loader = GameLoader.new
  end

  private

  def start_app
    saved_game = @game_loader.run_saved_games
    p saved_game

    start_game saved_game
  end

  def start_game game
    @word = Word.new
    @game = Game.new

    unless game.nil?
      map_saved_game_to_game_word game
    end

    game_start_instructions @game.attempts_left
  end

  def game_start_instructions attempts = nil
    attempts ||= @game.attempts_left
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

 def match_saved_game saved_game = nil
   if !saved_game.nil? && saved_game.is_a?(SavedGame)
     @word.word = saved_game.word
     @round = saved_game.round
     @game.attempts_left = saved_game.attempts_left
     @game.non_existent_letters = saved_game.non_existent_letters
     @game.existing_letters = saved_game.existing_letters
     @word.template = saved_game.template
   end
 end
end

# Manager
# - load game
# - save game
# - select saved games or start a new one

#   - A human player may save a game at any round.
#   - A human player may start one of the saved games with the word where they have left previous time.
#   - A human player may start a new game while playing a current one or once the game ends.
