require_relative './game_manager'
require_relative './word_manager'

class GameFlowManager
  def initialize
    @game_manager = GameManager.new
    @word_manager = WordManager.new
  end

  def start_game saved_game
      game_start_instructions saved_game&.attempts_left

      run_game saved_game
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
end
