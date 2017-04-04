require 'pry'
require './lib/board'
require "./lib/compliance_module"

class Computer
  include ComplianceMod

  attr_accessor :board, :moves
  def initialize(level=:beginner)
    @board = Board.new
    @board.setup(level)
    @moves = []
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
    ship_1 = validate_ship(2, generate_potential_ship)
    add_to_fleet(2, ship_1)
    ship_2 = validate_ship(3, generate_potential_ship)
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
    @board.add_ship(length, coordinates, :computer)
  end

  def validate_ship(length, coordinates)
    if length == 3 && check_fleet(length, coordinates, @board)
      validate_ship(length, generate_potential_ship)
    elsif computer_compliant?(length, coordinates)
      coordinates
    else
      validate_ship(length, generate_potential_ship)
    end
  end

  def computer_compliant?(length, coordinates)
    coordinates.pop if coordinates.length == 3
    coordinates = coordinates.join.split('')
    !(ship_too_long(length, coordinates) || ship_wraps_board(coordinates) || ship_diagonal(coordinates)|| same_coordinates(coordinates) || ship_too_short(length, coordinates)) 
  end
end