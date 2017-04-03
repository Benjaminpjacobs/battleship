require "./lib/player"
require "./lib/computer"
require "./lib/setup_module"
require "./lib/shot_sequence"
require 'pry'

class Session
  include Setup
  attr_reader :start_time, :player, :computer
  def initialize
    @start_time = Time.now.strftime("%H:%M:%S")
    @player = Player.new
    @computer = Computer.new
    @computer.make_fleet
  end
  
  # def game_flow
  #   get_player_fleet
  #   until @computer.board.fleet.values.empty? || @player.board.fleet.values.empty?
      
  # end
  
  def get_player_fleet
    puts "I have laid out my ships on the grid.
          You now need to layout your two ships.
          The first is two units long and the
          second is three units long.
          The grid has A1 at the top left and 
          D4 at the bottom right."
    two_unit_submission
    three_unit_submission
  end



private
  def two_unit_submission
    puts "Enter the squares for the two-unit ship:"
    submission = verify_submission(gets.chomp.split(' '), 2)

    coordinates = placement_compliance(2, submission, @player.board)
    @player.board.add_ship(2, coordinates)
  end

  def three_unit_submission
    puts "Enter the squares for the three-unit ship:"
    submission = verify_submission(gets.chomp.split(' '), 2)

    coordinates = placement_compliance(3, submission, @player.board)
    @player.board.add_ship(3, coordinates)
  end

end