module Winnerable
  def process_winner winner
    if !winner.nil? && winner == :human
      puts "You win."
      puts "The word is '#{@game.show_word}'."
      exit
    end
  end
end
