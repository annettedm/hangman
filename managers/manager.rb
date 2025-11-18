require_relative './serializer'
require_relative './loader'
require_relative '../models/word'
require_relative '../models/game'
require_relative '../modules/instructable'
require_relative '../modules/checkable'
require_relative '../modules/winnerable'

class Manager
  include Instructable
  include Checkable
  include Winnerable

  CONTROLS = {
    exit_game: "exit",
    new_game: "new",
    save_game: 'save'
  }

  def initialize
    @serializer = Serializer.new
    @loader = Loader.new @serializer
  end

  def start_app
    saved_game = @loader.run_saved_games

    start_game saved_game
  end

  private

  def ask_next
    control_instructions

    process_control get_control_entry
  end

  def start_game saved_game
    @game = Game.new

    process_saved_game_hash saved_game
    game_start_instructions
    run_game
  end

  def run_game
    while @game.attempts.positive?
      @game.add_round

      round_instructions
      # puts "the word is #{@game.show_word}"
      entry = get_alpha_entry

      if include_control? entry
        if process_control(entry) == :new
          return :new
        end
      else
        result = @game.process_entry(entry)
        process_winner result
        return ask_next if result == :human
      end
    end

    @serializer.remove_saved_game @saved_game_index
    puts "The game is over. A computer wins. The word is #{@game.show_word}."
    ask_next
  end

  def get_alpha_entry
    get_entry :alpha
  end

  def get_control_entry
    get_entry :control
  end

  def get_entry type
    entry = gets.chomp.downcase

    if type == :alpha
      until alphabetic? entry
        puts "Please, enter letters only."
        entry = gets.chomp.downcase
      end
    elsif type == :control
      until entry == CONTROLS[:new_game] || entry == CONTROLS[:exit_game]
        puts "Please, enter '#{CONTROLS[:new_game]}' or '#{CONTROLS[:exit_game]}' only."
        entry = gets.chomp.downcase
      end
    end
    entry
  end

  def include_control? entry
    CONTROLS.values.include? entry
  end

  def process_control entry
    if CONTROLS[:exit_game] == entry
      puts "You quit the game."
      exit
    end
    if CONTROLS[:new_game] == entry
      return :new
    end
    if CONTROLS[:save_game] == entry
      remove_saved_game
      @serializer.save_game @game
      ask_next
    end
  end

  def process_saved_game_hash saved_game
    unless saved_game.nil?
      @saved_game_index = saved_game.keys[0]

      @game.map_saved_to_game saved_game[@saved_game_index]
    end
  end

  def remove_saved_game
    unless @saved_game_index.nil?
      @serializer.remove_saved_game @saved_game_index
    end
  end
end

# Manager
# - load game
# - save game
# - select saved games or start a new one

#   - A human player may save a game at any round.
#   - A human player may start one of the saved games with the word where they have left previous time.
#   - A human player may start a new game while playing a current one or once the game ends.
