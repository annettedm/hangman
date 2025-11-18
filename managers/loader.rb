require_relative './serializer'

class Loader
  attr_reader :game_index

  START_GAME_FLOW_CONTROLS = {
    start_new_game: 0
  }

  def initialize serializer
    @serializer = serializer
  end

  def run_saved_games
    saved_games = get_saved_games

    if !saved_games.nil? && saved_games.count.positive?
      saved_games_count = saved_games.count

      saved_games_instructions saved_games_count
      show_saved_games saved_games

      player_entry saved_games_count

      {@game_index => saved_games[@game_index]} unless @game_index.nil?
    end
  end

  private

  def get_saved_games
    @serializer.games
  end

  def saved_games_instructions saved_games_count
    puts "You have #{saved_games_count == 1 ? 'a saved game' : 'saved games'} that you can continue playing."
    puts "Enter game number or enter '#{START_GAME_FLOW_CONTROLS[:start_new_game]}' to start a new game."
  end

  def show_saved_games saved_games
    saved_games.each_with_index do |game, i|
      puts "#{i + 1} --> #{game.template}"
    end
  end

  def player_entry saved_games_count
    entry = get_direct_entry

    loop do
      if numeric? entry
        entry = entry.to_i
        if entry.between?(0, saved_games_count)
          @game_index = entry - 1 unless entry == 0
          break
        else
          puts "Please, enter digits displayed for a game or '#{START_GAME_FLOW_CONTROLS[:start_new_game]}' to start a new game."

          entry = get_direct_entry
          next
        end
      else
        puts "Please, enter digits only."
        entry = get_direct_entry
        next
      end
    end
  end

  def numeric? entry
    entry.match?(/\A\d+\z/)
  end

  def get_direct_entry
    gets.chomp.downcase
  end
end
