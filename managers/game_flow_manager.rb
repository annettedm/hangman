require_relative './game_manager'
require_relative './word_manager'

class GameFlowManager
  def initialize
    @game_manager = GameManager.new
    @word_manager = WordManager.new
  end
end
