require_relative './saved_game'
require_relative './serializable'

class SaveGameManager
  include Serializable

  FILE_NAME = 'saved_games.json'


  def initialize
    @games = []
  end

  def save_game game, round
    add_game game, round
    serialize
  end

  def games
    deserialize
    @games
  end

  private

  def add_game game, round
    @games << match_game_to_saved_game(game, round)
  end

  def match_game_to_saved_game game, round
    SavedGame.new(
      game.show_word,
      round,
      game.attempts_left,
      game.non_existent_letters,
      game.existing_letters,
      game.word_template)
  end

  def clear_file
    File.open(file_path, 'w') do |file| ; end
  end

  def deserialize
    @games = []

    file = games_from_file
    if file.length > 0
      parsed_data = @@serializer.parse file
      # puts "parsed data: #{parsed_data}"
      parsed_data.each do |game_string|
        # puts "game string: #{game_string}"
        saved_game = SavedGame.new "", 0, 0, [], [], []

        saved_game.unserialize(game_string)
        @games << saved_game
      end
    end
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
