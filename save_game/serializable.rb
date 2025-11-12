require 'json'

module Serializable
  @@serializer = JSON

  def serialize
    obj = {}
    instance_variables.map do |var|
      obj[var] = instance_variable_get var
    end
    @@serializer.dump obj
  end

  def unserialize string
    obj = @@serializer.parse string

    obj.keys.each do |key|
      instance_variable_set key, obj[key]
    end
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
