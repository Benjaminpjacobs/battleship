require 'pry'
require './lib/board'
require "./lib/compliance_module"

class Computer
  include ComplianceMod
  attr_accessor :board, :moves
  
  LEVEL_SETTING = {beginner:[2,'D',4] , intermediate:[3,'H',8], advanced:[4,'L',12]}
  def initialize(level=:beginner)
    @board = Board.new
    @board.setup(level)
    @moves = []
    @level = level
  end

  def show_board
    @board.display_board
  end

  def fleet
    @board.fleet
  end

  def guess
    @moves << generate_coordinate
    @moves.last
  end
  
  def evaluate_move(coordinate)
    @board.evaluate_move(coordinate)
  end

  def make_fleet
    return make_fleet_large if @level == :advanced
    i = 2
    LEVEL_SETTING[@level][0].times do 
      ship = validate_ship(i, generate_potential_ship)
      add_to_fleet(i, ship)
      i += 1
    end
  end
    
  def make_fleet_large
    i = 2
    LEVEL_SETTING[@level][0].times do
    ship = validate_ship(i, generate_large_board_ship(i))

    add_to_fleet(i, ship)
    i += 1
    end
  end
  
  def generate_large_board_ship(length)

    ship = []
    start = generate_coordinate
    ship << start
    x = (start[0].."L").to_a
    y = (start[1..-1].."12").to_a
    chance = rand(2)
    if chance.zero? && x[0] && y[length -1]
      ship << x[0] + y[length -1]
    elsif x[length-1] && y[0]
      ship <<  x[length - 1] + y[0]
    elsif x[0] && y[length-1]
      ship <<  x[0] + y[length-1]
    else
      generate_large_board_ship(length)
    end
    # binding.pry
    ship
  end


  def generate_coordinate
    ("A"..LEVEL_SETTING[@level][1]).to_a.shuffle.pop + rand(1..LEVEL_SETTING[@level][2]).to_s
  end

  def generate_potential_ship
      coordinates = []
      coordinates[0], coordinates[1] = generate_coordinate, generate_coordinate
  end

  def add_to_fleet(length, coordinates)
    @board.add_ship(length, coordinates, :computer)
  end

  def validate_ship(length, coordinates)
    if length >= 3 && check_fleet(length, coordinates, @board)
      validate_ship(length, generate_potential_ship)
    elsif computer_compliant?(length, coordinates)
      coordinates
    else
      validate_ship(length, generate_potential_ship)
    end
  end

  def computer_compliant?(length, coordinates)
    if coordinates.length >= 3
      # binding.pry
      coordinates.pop until coordinates.length == 2
    end
    coordinates = coordinates.join.split('')
    combine_double_digits(coordinates) if coordinates.length >= 5
    # binding.pry
    !(ship_too_long(length, coordinates) || ship_wraps_board(coordinates) || ship_diagonal(coordinates)|| same_coordinates(coordinates) || ship_too_short(length, coordinates)) 
  end

  def combine_double_digits(coordinates)
    if coordinates.length == 5 && ("A"..LEVEL_SETTING[@level][1]).to_a.include?(coordinates[2])
      coordinates[3] = coordinates[3] + coordinates[4]
      coordinates.delete_at(4)
    elsif coordinates.length == 5 
      coordinates[1] = coordinates[1] + coordinates[2]
      coordinates.delete_at(2)
    else
      coordinates[1] = coordinates[1] + coordinates[2]
      coordinates[4] = coordinates[4] + coordinates[5]
      coordinates.delete_at(2)
      coordinates.delete_at(4)
    end    
    coordinates
  end

end