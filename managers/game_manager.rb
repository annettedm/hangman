require_relative '../models/game'
require_relative '../models/word'

class GameManager


  def initialize
    @game = Game.new
    @round = 0
  end

  private

  def round_instructions
    puts "Round #{@round}"
    puts "You have #{@game.attempts_left} attempts."
    puts "Already used: #{@game.non_existent_letters.join(', ')}" if @game.non_existent_letters.length > 0
    puts word_template
  end

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
      @save_game_manager.save_game @game, @word, @round
    end
  end



  def run_game saved_game = nil
    new_game = false
    match_saved_game saved_game

    while @game.attempts_left > 0 && !new_game
      puts "*****************************"
      @round += 1

      round_instructions
      # @game.show_word
      entry = get_entry

      if GAME_FLOW_CONTROLS.values.include? entry
        new_game = manage_game_control entry
      else
        winner_status = @game.manage_entry(entry)

        manage_winner_status(winner_status) if winner_status
      end

    end

    if new_game
      {new_game: true}
    else
      puts "The game is over. A computer wins. The word is #{@game.show_word}."
    end
  end

end
