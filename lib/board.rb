require "./lib/boardmaker_module"
require "./lib/repl"

class Board
  include BoardMaker
  attr_accessor :board, :fleet, :interface

  def initialize(interface)
    @board = [] 
    @fleet = {}
    @interface = interface
  end

  def display_board
    @board.each do |line|
      interface.display(line.join)
    end
  end
  
  def setup(level=:beginner)
    @board = make_board(level)
  end

  def hit(coordinate)
    coordinate = parse_location(coordinate)
    @board[coordinate[0]][coordinate[1]] = "  H  "
  end

  def miss(coordinate)
    coordinate = parse_location(coordinate)
    @board[coordinate[0]][coordinate[1]] = "  M  "
  end

  def add_ship(ship, coordinates, user=nil)
    if ship > 2
      @fleet[ship] = interpolate_coordinates(ship,coordinates)
    else
      @fleet[ship] = coordinates
    end
    display_ship_on_board(@fleet[ship]) if user.nil?
  end
  
  def evaluate_move(coordinates)
    if already_played(coordinates)
      return false
    elsif @fleet.values.flatten.include?(coordinates)
      hit(coordinates)
    else
      miss(coordinates)
    end
  end

  def already_played(coordinate)
    coordinate = parse_location(coordinate)
    @board[coordinate[0]][coordinate[1]] == "  M  " || @board[coordinate[0]][coordinate[1]] == "  H  "
  end

  def interpolate_coordinates(ship, coordinates)
    if same_first_coordinate(coordinates)
      interpolated = generate_interpolated_right(ship, coordinates)
    elsif same_second_coordinate(coordinates)
      interpolated = generate_interpolated_left(ship, coordinates)
    else
      return false
    end
    coordinates << interpolated
    coordinates.flatten!
  end
  
  def display_ship_on_board(coordinates)
    coordinates.each do |coordinate|
      location = parse_location(coordinate)
      @board[location[0]][location[1]] = "  ∆  "
    end
  end

# private

  def parse_location(location)
    coordinate = []
    location = Array.new.push(location[0], location[1..-1])
    turn_string_into_digits(location)
  end

  def turn_string_into_digits(location)
    y_axis = {'A' => 2,'B' => 3,
              'C' => 4,'D' => 5,
              'E' => 6,'F' => 7,
              'G' => 8,'H' => 9,
              'I' => 10, 'J' =>  11,
              'K' => 12, 'L' => 13}
    location[1] = location[1].to_i
    location[0] = y_axis[location[0]]
    location
  end

  def generate_interpolated_right(ship, coordinates)
    sub_array = []
    collection = (coordinates[0][1..-1].."12").cycle
    collection.next
    (ship-2).times do |i|
      sub_array << coordinates[0].split('')[0] + collection.next#cycle[i+1]
    end
    sub_array
  end

  def generate_interpolated_left(ship, coordinates)
    sub_array = []
    collection = (coordinates[0].split('')[0].."L").cycle
    collection.next
    (ship-2).times do |i|
      sub_array <<  collection.next + coordinates[1][1..-1]  #cycle[i+1]
    end
    sub_array
  end

  def same_first_coordinate(coordinates)
    coordinates[0].split('')[0] == coordinates[1].split('')[0]
  end
  
  def same_second_coordinate(coordinates)
    coordinates[0][1..-1] == coordinates[1][1..-1]
  end
end
