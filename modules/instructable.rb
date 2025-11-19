module Instructable
  def game_start_instructions
    puts "************************************************"
    puts "************************************************"
    puts "We play a Hangman game. A player guesses a word."
    puts "Each space in a word is for a letter. Once you guess a letter, it takes its place."
    puts "You have #{@game.attempts} attempts to guess the word by letters. You can enter the whole word or only a letter."
    puts "If you enter a word and it matches the computer word, you win."
    puts "If a letter is not in the word, an attempt is utilized. Once #{@game.attempts} attempts are over, a computer wins."
    puts "Enter '#{Manager::CONTROLS[:new_game]}' to start a new game."
    puts "Enter '#{Manager::CONTROLS[:exit_game]}' to stop the game."
    puts "Enter '#{Manager::CONTROLS[:save_game]}' to save the game."
  end

  def round_instructions
    puts "*****************************"
    puts "Round #{@game.round}"
    puts "You have #{@game.attempts} attempts."
    puts "Already used: #{@game.non_existent_letters.join(', ')}" if @game.non_existent_letters.length > 0
    puts @game.template
  end

  def control_instructions
    puts "*****************************"
    puts "Enter '#{Manager::CONTROLS[:new_game]}' to start a new game."
    puts "Enter '#{Manager::CONTROLS[:exit_game]}' to stop the game."
  end
end
