require 'pry'
require './lib/board'
require "./lib/compliance_module"
require "Forwardable"

class Computer
  include ComplianceMod
  extend Forwardable
  attr_accessor :board, :moves

  def_delegator :@board, :display_board
  def_delegator :@board, :fleet
  def_delegator :@board, :evaluate_move
  
  LEVEL_SETTING = {beginner:[2,'D',4] , intermediate:[3,'H',8], advanced:[4,'L',12]}

  def initialize(level=:beginner,interface)
    @interface = interface
    @board = Board.new(@interface)
    @board.setup(level)
    @moves = []
    @level = level
  end

  def guess
    @moves << generate_coordinate
    @moves.last
  end

  def make_fleet
    i = 2
    LEVEL_SETTING[@level][0].times do 
      ship = validate_ship(i, generate_potential_ship)
      until ship
        ship = validate_ship(i, generate_potential_ship)
      end
      add_to_fleet(i, ship)
      i += 1
    end
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
    if !check_fleet(length, coordinates, @board) && computer_compliant?(length, coordinates)
      coordinates
    else
      false
    end
  end

  def computer_compliant?(length, coordinates)
    coordinates.pop until coordinates.length == 2 if coordinates.length >= 3
    coordinates = coordinates.join.split('')
    combine_double_digits(coordinates) if coordinates.length >= 5
    valid?(length, coordinates)
  end

  def valid?(length, coordinates)
    !(ship_too_long(length, coordinates) || 
    ship_wraps_board(coordinates) || 
    ship_diagonal(coordinates)|| 
    same_coordinates(coordinates) || 
    ship_too_short(length, coordinates)) 
  end

  def combine_double_digits(coordinates)
    if coordinates.length == 5 && ("A"..LEVEL_SETTING[@level][1]).to_a.include?(coordinates[2])
      combine_fourth_and_fifth(coordinates)
    elsif coordinates.length == 5 
      combine_second_and_third(coordinates)
    else
      combine_double_doubles(coordinates)
    end    
    coordinates
  end

private

  def combine_fourth_and_fifth(coordinates)
    coordinates[3] = coordinates[3] + coordinates[4]
    coordinates.delete_at(4)
  end

  def combine_second_and_third(coordinates)
    coordinates[1] = coordinates[1] + coordinates[2]
    coordinates.delete_at(2)
  end

  def combine_double_doubles(coordinates)
    coordinates[1] = coordinates[1] + coordinates[2]
    coordinates[4] = coordinates[4] + coordinates[5]
    coordinates.delete_at(2)
    coordinates.delete_at(4)
  end
end