require_relative './game_serializer'
require_relative './game_flow_manager'
require_relative './game_loader'

class Manager

  def initialize
    @game_loader = GameLoader.new
    @game_manager = GameFlowManager.new
  end

  def start_app
    @game_flow_manager.start_game @game_loader.run_saved_games
  end
end

# Manager
# - load game
# - save game
# - select saved games or start a new one

#   - A human player may save a game at any round.
#   - A human player may start one of the saved games with the word where they have left previous time.
#   - A human player may start a new game while playing a current one or once the game ends.
