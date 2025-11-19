require_relative '../models/saved_game'
require_relative '../modules/serializable'
require_relative '../modules/mappable'

class Serializer
  include Serializable
  include Mappable

  FILE_NAME = 'saved_games.json'

  def save_game game
    add_game game
    serialize
    puts "You have saved the game."
  end

  def games
    @games ||= deserialize
  end

  def remove_saved_game index
    if index.between?(0, @games.size - 1)
      @games.delete_at index
      if @games.length > 0
        serialize
      else
        clear_file
      end
    end
  end

  private

  def add_game game
    @games << map_game_to_saved(game)
  end

  def clear_file
    File.open(file_path, 'w') do |file| ; end
  end

  def deserialize
    games_list = []

    file = games_from_file
    if file.length > 0
      parsed_data = @@serializer.parse file
      parsed_data.each do |game_string|
        saved_game = SavedGame.new "", 0, 0, [], [], []

        saved_game.unserialize(game_string)
        games_list << saved_game
      end
    end
    games_list
  end

  def serialize
    if @games.length > 0
      games = @games.map do |game|
        if game.is_a? SavedGame
          game.serialize
        end
      end
      @@serializer.dump games
      File.open(file_path, 'w') do |file|
        file << games
      end
    end
  end


  def games_from_file
    file = File.new file_path, 'r'
    file.read
  end

  def file_path
    file_dir = File.expand_path('../assets', __dir__)

    File.join(file_dir, FILE_NAME)
  end
end
