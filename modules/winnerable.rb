module Winnerable
  def process_winner winner
    if winner == :human
      puts "You win."
      puts "The word is '#{@game.show_word}'."
      remove_saved_game
    end
  end
end
