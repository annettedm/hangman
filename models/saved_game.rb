require_relative '../modules/serializable'

class SavedGame
  include Serializable

  attr_accessor :word, :round, :attempts, :non_existent_letters, :existent_letters, :template

  def initialize word, round, attempts, non_existent_letters, existent_letters, template
    @word = word
    @round = round
    @attempts = attempts
    @non_existent_letters = non_existent_letters
    @existent_letters = existent_letters
    @template = template
  end
end

# Serialization implementation details
#   - array for games
#   - serialization object to add to an array
#     - template - used for displaying games to select
#     - word
#     - existent letters
#     - non-existent letters
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
