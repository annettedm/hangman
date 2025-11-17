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

    end
