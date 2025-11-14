require_relative '../modules/serializable'

class SavedGame
  include Serializable

  attr_accessor :word, :round, :attempts_left, :non_existent_letters, :existing_letters, :template

  def initialize word, round, attempts_left, non_existent_letters, existing_letters, template
    @word = word
    @round = round
    @attempts_left = attempts_left
    @non_existing_letters = non_existent_letters
    @existing_letters = existing_letters
    @template = template
  end
end

# Serialization implementation details
#   - array for games
#   - serialization object to add to an array
#     - template - used for displaying games to select
#     - word
#     - existing letters
#     - non-existing letters
#     - round number
#     - attempts left
#   - serialization on a certain word
#   - file to serialize to

# Deserialize
#  - check if a file exists -> handling as a words file
#  - read array of games
#  - deserialize into an array of game states
#  - show templates list of the saved games
#  - once a game is selected, this object is deleted from the file
