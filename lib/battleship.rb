require "./lib/session.rb"
require "./lib/messages.rb"
require "./lib/repl.rb"
require 'pry'

class Battleship
  include Messages
  attr_accessor :interface

  def initialize
    @interface = Repl.new
  end

  def menu
    welcome
    input = interface.get
    loop_till_valid(input)
    quit_message
  end

  def welcome
    interface.display(WELCOME) 
  end
 
  def instructions
    interface.display(INSTRUCTIONS)
  end

  def quit_message
    interface.display(QUITTER)
    interface.say(QUITTER)
  end

  def play_battleship
    interface.say(PLAY)
    s = Session.new
    s.game_flow
  end

private
  
  def loop_till_valid(input)
    until input == 'q'
      response(input)
      input = interface.get
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

end

##############
b = Battleship.new
b.menu
