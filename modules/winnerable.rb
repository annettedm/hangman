module Winnerable
  def process_winner winner
    if winner == :human
      puts "You win."
      puts "The word is '#{@game.show_word}'."
      puts "index #{@saved_game_index}"
      p @serializer.games
      remove_saved_game
      p @serializer.games
    end
  end
end
