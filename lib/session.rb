require "./lib/player"
require 'pry'

class Session
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

  def placement_compliance(length, coordinates)
    if length == 3 && check_fleet(length, coordinates)
      puts "Ships cannot overlap"
      puts "please choose new coordinates"
      placement_compliance(length, gets.chomp.split(' '))
    elsif compliant?(length, coordinates) == :valid
      coordinates
    else
      puts compliant?(length, coordinates)
      puts "please choose new coordinates"
      placement_compliance(length, gets.chomp.split(' '))
    end
  end

  def check_fleet(length, coordinates)
    @fleet.values.flatten.include?(coordinates[0]) || @fleet.values.flatten.include?(coordinates[1])
  end

  def compliant?(length, coordinates)
    coordinates = coordinates.join.split('')
    if ship_too_long(length, coordinates)
      "Coordinates must correspond to the first and last units of the ship. (IE: You can’t place a two unit ship at “A1 A3”)"
    elsif ship_wraps_board(coordinates)
      "Ships cannot wrap around the board"
    elsif ship_diagonal(coordinates)
      "Ships must be horizontal or vertical"
    else
      :valid
    end
  end

  def ship_too_long(length, coordinates)
    (coordinates[3].ord - coordinates[1].ord) >= length ||(coordinates[2].ord - coordinates[0].ord) >= length
  end
  
  def ship_wraps_board(coordinates)
    coordinates[1].ord > coordinates[3].ord || coordinates[0].ord > coordinates[2].ord  
  end
  def ship_diagonal(coordinates)
    coordinates[1].to_i != coordinates[3].to_i &&
    coordinates[0] != coordinates[2]
  end

  def play_game
    
  end
end