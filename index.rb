require_relative './managers/manager'

def start_app
  result = Manager.new.start_app

  if result == :new
    puts "******************* New Game *******************"
    start_app
  end
end

start_app
