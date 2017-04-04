require "./lib/session.rb"
require "./lib/messages.rb"
require 'pry'
class Battleship
  include Messages

  def menu
    welcome
    input = player_input
    loop_till_valid(input)
    quit_message
  end

  def welcome
    puts WELCOME
  end
 
  def instructions
    puts INSTRUCTIONS
  end

  def quit_message
    puts QUITTER
    `say -v Ralph "You'll never sink my battleship with 
    that attitude"` 
  end

  def play_battleship
    `say -v Ralph "Let's play battle ship"`
    s = Session.new
    s.game_flow
  end

private
  
  def loop_till_valid(input)
    until input == 'q'
      response(input)
      input = player_input
    end
  end

  def response(answer)
    if answer == "i" 
      instructions
    elsif answer == "p"
      play_battleship
    else
      return
    end
  end

  def player_input
    gets.chomp.downcase
  end
end

##############
b = Battleship.new
b.menu
