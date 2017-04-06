require "./lib/session.rb"
require "./lib/messages.rb"
require "./lib/repl.rb"

class Battleship
  include Messages
  attr_accessor :interface

  def initialize
    @interface = Repl.new
  end

  def menu
    interface.display(welcome)
    input = interface.get
    loop_till_valid(input)
    interface.display(quit_message)
  end

  def welcome
    WELCOME
  end
 
  def instructions
    INSTRUCTIONS
  end

  def quit_message
    QUITTER
  end

  def play_battleship
    level = choose_level
    interface.say(PLAY)
    s = Session.new(level)
    s.game_flow
  end

  def choose_level
    interface.display(LEVEL)
    level = interface.get.downcase
    levels = {'b' => :beginner,
              'i' => :intermediate,
              'a'=> :advanced}
    levels[level]
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
      interface.display(instructions)
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
