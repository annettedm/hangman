module Mappable
  def map_saved_to_game saved_game
    if saved_game.is_a?(SavedGame)
      @word.word = saved_game.word
      @round = saved_game.round
      @attempts = saved_game.attempts
      @non_existent_letters = saved_game.non_existent_letters
      @existent_letters = saved_game.existent_letters
      @word.template = saved_game.template
    end
  end

  def map_game_to_saved game
    SavedGame.new(
      game.show_word,
      game.round,
      game.attempts,
      game.non_existent_letters,
      game.existent_letters,
      game.template)
  end
end
