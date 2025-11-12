require_relative './manager'

def start_app
  result = Manager.new.start_app

  if result && result[:new_game]
    puts "******************* New Game *******************"
    start_app
  end
end

start_app
