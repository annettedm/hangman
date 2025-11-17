require_relative '../models/game'
require_relative '../models/word'

class GameManager


  def initialize
    @game = Game.new
    @round = 0
  end

  private

  def word_template
      @game.word_template
  end

  def get_entry
    entry = gets.chomp.downcase

    until alphabetic? entry
      puts "Please, enter letters only."
      entry = gets.chomp.downcase
    end

    entry
  end

  def alphabetic? value
    value.match?(/\A[a-zA-Z]+\z/)
  end

  def manage_winner_status status
    if status[:winner] == "human"
      puts "You win."
    elsif status[:winner] == "computer"
      puts "Computer wins as attempts are over."
    end
    puts "The word is '#{status[:word]}'."
    exit
  end

  def manage_game_control entry
    if GAME_FLOW_CONTROLS[:stop_game] == entry
      exit
    end
    if GAME_FLOW_CONTROLS[:new_game] == entry
      return true
    end
    if GAME_FLOW_CONTROLS[:save_game] == entry
      @save_game_manager.save_game @game, @word
    end
  end



end
