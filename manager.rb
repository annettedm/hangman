require_relative './word'
require_relative './game'
require_relative './game_state'

class Manager
  def initialize
    @game = Game.new
    @round = 0
  end

  def start_game
    game_start_instructions

    run_game
  end

  def run_game
    while @game.attempts_left > 0
      puts "*****************************"
      @round += 1

      round_instructions

      # @game.show_word
      @game.manage_entry(get_entry)
    end
    puts "The game is over. A computer wins. The word is #{@game.show_word}."
  end

  private

  def game_start_instructions
    puts "We play a Hangman game. A player guesses a word."
    puts "Each space in a word is for a letter. Once you guess a letter, it takes its place."
    puts "You have 7 attempts to guess the word by letters. You can enter the whole word or only a letter."
    puts "If you enter a word and it matches the computer word, you win."
    puts "If a letter is not in the word, an attempt is used. Once 7 attempts are over, a computer wins."
  end

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

    while !alphabetic? entry
      puts "Please, enter letters only."
      entry = gets.chomp.downcase
    end
    entry
  end

  def alphabetic? value
    value.match?(/\A[a-zA-Z]+\z/)
  end
end

# Manager
# - load game
# - save game
# - select saved games or start a new one
# - start a game
# - manage letter entry - do round


#   - A human player guesses a word that a computer has selected for a game.
#   - There are 7 failed attempts until a human player fails in a game for guessing a word.
#   - Before the first round a computer shows empty spaces for the letters in a word (word template) so that a human play could see the length of the word.
#   - A human player may suggest the whole word or only a letter in a round.
#   - If a human player enters a correct letter, it shows in the updated word template.
#   - If a human player enters the whole word and the word is correct, the human player wins and the game is over.
#   - If a human player enters the whole word and the word is incorrect, it is considered to be 1 failed attempt.
#   - If a human player enters a wrong/non-existing letter, it is considered to be 1 failed attempt.
#   - When there are 7 failed attempts/non-existing letters, a computer player wins, the game is over.
#   - If a human player guesses a word, a human player wins, the game is over.
#   - A human player may save a game at any round.
#   - A human player may start one of the saved games with the word where they have left previous time.
#   - A human player may start a new game while playing a current one or once the game ends.

# Flow details
#   - a random word between 5 and 12 characters long
#   - number of failed attempts left
#   - a word template with correct letters and spaces
#   - incorrect letters that have been entered
#   - human entry -> case-insensitive
#   - show to a user if a guess is correct or not
#   - show to a use when the fail attempts are over and the game is over
