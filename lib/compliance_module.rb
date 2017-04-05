require './lib/messages'
require './lib/repl'
require 'pry'
module ComplianceMod
  include Messages

  GRID_SIZE = { beginner:     [("A".."D").to_a,("1".."4").to_a],
                intermediate: [("A".."H").to_a,("1".."8").to_a], 
                advanced:     [("A".."L").to_a,("1".."12").to_a] 
              }

  def verify_submission(submission, expected_length, level=:beginner)
    result = verification(submission, expected_length, level)
    until result.is_a?(Array)
      interface.display(result)
      submission = interface.get.upcase.split(' ')
      result = verification(submission, expected_length, level)
    end
    result
  end

  def placement_compliance(length, coordinates, board, level=:beginner)
    result = new_submission_valid(length, coordinates, board)
    until result.is_a?(Array)
      interface.display(result)
      coordinates = verify_submission(interface.get.upcase.split(' '), 2, level)
      result = new_submission_valid(length, coordinates, board)
    end
    result
  end

  def verification(submission, expected_length, level=:beginnner)
    if submission.length != expected_length 
      IMPROPER_INPUT
    elsif !outside_grid(submission, level)
      OUTSIDE_GRID
    else
      submission
    end
  end
 
  def new_submission_valid(length, coordinates, board)
    if length == 3 && check_fleet(length, coordinates, board)
      SHIPS_OVERLAP
    elsif check_compliance(length, coordinates) == :valid
      coordinates
    else
      check_compliance(length, coordinates)
    end
  end

  def check_compliance(length, coordinates)
    coordinates.pop if coordinates.length == 3
    coordinates = coordinates.join.split('')
    combine_double_digits(coordinates) if coordinates.length > 4
    display_applicable_error_message(length, coordinates)
  end

  def display_applicable_error_message(length, coordinates)
    
    if ship_too_long(length, coordinates) 
      SHIP_TOO_LONG_OR_SHORT
    elsif ship_wraps_board(coordinates)
      SHIP_CANNOT_WRAP
    elsif ship_too_short(length, coordinates) || same_coordinates(coordinates)
      SHIP_TOO_LONG_OR_SHORT
    elsif ship_diagonal(coordinates)
      CANNOT_BE_DIAGONAL
    else
      :valid
    end
  end

  def check_fleet(length, coordinates, board)
    check = board.interpolate_coordinates(length, coordinates)
    if !check
      false
    else
      check.any? do |check|
        board.fleet.values.flatten.include?(check)
      end
    end
  end

  def ship_too_long(length, coordinates)
    (coordinates[3].ord - coordinates[1].ord) >= length || 
    (coordinates[2].ord - coordinates[0].ord) >= length
  end

  def ship_too_short(length, coordinates)
    !((coordinates[3].to_i - coordinates[1].to_i) == (length-1) || 
    (coordinates[2].ord - coordinates[0].ord) == (length-1))
  end

  def ship_wraps_board(coordinates)
    coordinates[1].to_i > coordinates[3].to_i || 
    coordinates[0].ord > coordinates[2].ord  
  end

  def ship_diagonal(coordinates)
    coordinates[1].to_i != coordinates[3].to_i &&
    coordinates[0] != coordinates[2]
  end

  def same_coordinates(coordinates)
    (coordinates[0] == coordinates[2]) && 
    (coordinates[1] == coordinates[3])
  end

  def outside_grid(coordinates, level=:beginner)
    coordinates.all? do |coordinate|
      GRID_SIZE[level][0].include?(coordinate[0]) &&
      GRID_SIZE[level][1].include?(coordinate[1..-1])
    end
  end

  def combine_double_digits(coordinates)
    if coordinates.length == 5 && ("A".."L").to_a.include?(coordinates[2])
      combine_fourth_and_fifth(coordinates)
    elsif coordinates.length == 5 
      combine_second_and_third(coordinates)
    else
      combine_double_doubles(coordinates)
    end    
    coordinates
  end

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