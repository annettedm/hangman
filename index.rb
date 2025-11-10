require_relative './manager'

def start_game
  result = Manager.new.start_game

  if result && result[:new_game]
    puts "******************* New Game *******************"
    start_game
  end
end

start_game
