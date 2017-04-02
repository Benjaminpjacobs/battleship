require 'pry'
require './lib/board'
require './lib/setup_module'

class Computer
  include Setup

  attr_accessor :board, :moves
  def initialize
    @board = Board.new
    @board.setup
    @moves = []
  end

  def guess
    move = generate_coordinate 
    if @moves.include?(move)
      guess
    else
      @moves << move
    end
   move
  end

  def make_fleet
    ship_1 = placement_compliance(2, generate_potential_ship)
    add_to_fleet(2, ship_1)
    ship_2 = placement_compliance(3, generate_potential_ship)
    add_to_fleet(3, ship_2)
  end

  def generate_coordinate
    ("A".."D").to_a.shuffle.pop + rand(1..4).to_s
  end

  def generate_potential_ship
      coordinates = []
      coordinates[0], coordinates[1] = generate_coordinate, generate_coordinate
  end

  def add_to_fleet(length, coordinates)
    @board.add_ship(length, coordinates)
  end

  def placement_compliance(length, coordinates)
    if length == 3 && check_fleet(length, coordinates)
      placement_compliance(length, generate_potential_ship)
    elsif compliant?(length, coordinates)
      coordinates
    else
      placement_compliance(length, generate_potential_ship)
    end
  end

  def compliant?(length, coordinates)
    coordinates = coordinates.join.split('')
    !(ship_too_long(length, coordinates) || ship_wraps_board(coordinates) || ship_diagonal(coordinates)|| same_coordinates(coordinates) || ship_too_short(length, coordinates)) 
  end

  def ship_too_long(length, coordinates)
    (coordinates[3].ord - coordinates[1].ord) >= length ||(coordinates[2].ord - coordinates[0].ord) >= length
  end

  def ship_too_short(length, coordinates)
    !((coordinates[3].ord - coordinates[1].ord) == (length-1) ||(coordinates[2].ord - coordinates[0].ord) == (length-1))
  end

  def ship_wraps_board(coordinates)
    coordinates[1].ord > coordinates[3].ord || coordinates[0].ord > coordinates[2].ord  
  end

  def ship_diagonal(coordinates)
    coordinates[1].to_i != coordinates[3].to_i &&
    coordinates[0] != coordinates[2]
  end

  def same_coordinates(coordinates)
    (coordinates[0] == coordinates[2]) && (coordinates[1] == coordinates[3])
  end

  def check_fleet(length, coordinates)
    check = @board.interpolate_coordinates(coordinates)
    coordinates.pop
    @board.fleet.values.flatten.include?(check[0]) || @board.fleet.values.flatten.include?(check[1]) ||
    @board.fleet.values.flatten.include?(check[2])
  end
end