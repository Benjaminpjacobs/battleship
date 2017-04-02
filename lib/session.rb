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
    @computer = Computer.new
    @computer.make_fleet
  end
  
  def play_game
    
  end
  
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
    submission = verify_submission(gets.chomp.split(' '))

    coordinates = placement_compliance(2, submission, @player.board)
    @player.board.add_ship(2, coordinates)
  end

  def three_unit_submission
    puts "Enter the squares for the three-unit ship:"
    submission = verify_submission(gets.chomp.split(' '))

    coordinates = placement_compliance(3, submission, @player.board)
    @player.board.add_ship(3, coordinates)
  end
  
  def verify_submission(submission)
    if submission.length != 2
      puts "Please enter two coordinates separated by a space.(i.e A1 A2 for 2 unit ship or B1 B3 for three unit ship)"
      verify_submission(gets.chomp.split(' '))
    else
      submission
    end
  end
 
end