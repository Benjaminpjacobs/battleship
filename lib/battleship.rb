require "./lib/session.rb"
require "./lib/messages.rb"
class Battleship
  include Messages

  def menu
    puts WELCOME
    response
  end  

  def quit_message
    puts QUITTER
    `say -v Ralph "You'll never sink my battleship with that attitude"`
  end

  def instructions
    puts INSTRUCTIONS
    response
  end

  def response
    answer = gets.chomp.downcase
      if answer == "p"
        play_battleship
      elsif answer == "i"
        instructions
      elsif answer == 'q'
        quit_message
      end
  end

  def play_battleship
    `say -v Ralph "Let's play battle ship"`
    s = Session.new
    s.game_flow
  end
end

###############
b = Battleship.new
b.menu
