A hangman game.

A commandline/console game written in Ruby. 

A human player plays against a computer. A computer has a predefined file with 10,000 words to select from. 
  - When a game is started, a random word is selected by a computer player to guess.
  - A human player guesses a word that a computer has selected for a game. 
  - There are 7 failed attempts until a human player fails in a game for guessing a word. 
  - Before the first round a computer shows empty spaces for the letters in a word (word template) so that a human play could see the length of the word. 
  - A human player may suggest the whole word or only a letter in a round. 
  - If a human player enters a correct letter, it shows in the updated word template.
  - If a human player enters the whole word and the word is correct, the human player wins and the game is over.
  - If a human player enters the whole word and the word is incorrect, it is considered to be 1 failed attempt.
  - If a human player enters a wrong/non-existing letter, it is considered to be 1 failed attempt.
  - When there are 7 failed attempts/non-existing letters, a computer player wins, the game is over.
  - If a human player guesses a word, a human player wins, the game is over.
  - A human player may save a game at any round.
  - A human player may start one of the saved games with the word where they have left previous time. 
  - A human player may start a new game while playing a current one or once the game ends.

Game
  - a random word between 5 and 12 characters long 
  - number of failed attempts left 
  - a word template with correct letters and spaces 
  - incorrect letters that have been entered 
  - human entry -> case-insensitive 
  - show to a user if a guess is correct or not 
  - show to a use when the fail attempts are over and the game is over 


