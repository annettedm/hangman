class DisplaySavedGamesManager
  START_GAME_FLOW_CONTROLS = {
    start_new_game: 0
  }

  def run_saved_games
    saved_games = get_saved_games

    saved_games_count = saved_games.count

    if saved_games != nil && saved_games_count > 0

      saved_games_instructions saved_games_count
      show_saved_games saved_games

      entry = player_entry saved_games_count
    end
  end

  def get_saved_games
    @save_game_manager.games
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

    entry = gets.chomp.downcase

      until numeric? entry
        puts "Please, enter digits only."
        entry = gets.chomp.downcase
      end

      entry

  end

  def numeric? entry

  end
end
