require_relative './save_game/save_game_manager'
require_relative './game/game_manager'
require_relative './save_game/display_saved_games_manager'

class Manager

  def initialize
    @save_game_manager = SaveGameManager.new
    @display_sg_manager = DisplaySavedGamesManager.new
    # @game_manager = GameManager.new
  end

  def start_app
    @display_sg_manager.run_saved_games

    # run_game
  end
end

# Manager
# - load game
# - save game
# - select saved games or start a new one

#   - A human player may save a game at any round.
#   - A human player may start one of the saved games with the word where they have left previous time.
#   - A human player may start a new game while playing a current one or once the game ends.
