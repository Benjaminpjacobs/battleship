require "./lib/player"
require "./lib/computer"
require "./lib/setup_module"
require 'pry'

class Session
  include Setup
  attr_reader :start_time, :player, :computer
  def initialize
    @start_time = Time.now.strftime("%H:%M:%S")
    @player = Player.new
    @computer = '' #Computer.new
    @fleet = {}
  end

  def get_player_fleet
    puts "I have laid out my ships on the grid.
          You now need to layout your two ships.
          The first is two units long and the
          second is three units long.
          The grid has A1 at the top left and 
          D4 at the bottom right."

     puts "Enter the squares for the two-unit ship:"
     @fleet[2] = placement_compliance(2, gets.chomp.split(' '))

     puts "Enter the squares for the three-unit ship:"
     @fleet[3] = placement_compliance(3, gets.chomp.split(' '))
  end


  def play_game
    
  end
end