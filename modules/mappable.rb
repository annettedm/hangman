module Mappable
  def map_saved_game_to_game_word saved_game
    if saved_game.is_a?(SavedGame)
      @word.word = saved_game.word
      @game.round = saved_game.round
      @game.attempts_left = saved_game.attempts_left
      @game.non_existent_letters = saved_game.non_existent_letters
      @game.existent_letters = saved_game.existent_letters
      @word.template = saved_game.template
    end
  end

  def map_game_word_to_saved_game game, word
    SavedGame.new(
      word.word,
      game.round,
      game.attempts_left,
      game.non_existent_letters,
      game.existent_letters,
      word.template)
  end
end
