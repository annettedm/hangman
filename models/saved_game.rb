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
