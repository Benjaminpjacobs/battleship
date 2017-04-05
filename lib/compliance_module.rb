require './lib/messages'
module ComplianceMod
  include Messages

  GRID_SIZE = { beginner:     [("A".."D").to_a,("1".."4").to_a],
                intermediate: [("A".."H").to_a,("1".."8").to_a], 
                advanced:     [("A".."L").to_a,("1".."12").to_a] 
              }

  def verify_submission(submission, expected_length, level=:beginner)
    until verification(submission, expected_length, level)
      submission = get_input
    end
    submission
  end

  def verification(submission, expected_length, level)
    if submission.length != expected_length 
      puts IMPROPER_INPUT
      return false
    elsif !outside_grid(submission, level)
      puts OUTSIDE_GRID
      return false
    else
      submission
    end
  end

  def placement_compliance(length, coordinates, board, level=:beginner)
    until new_submission_valid(length, coordinates, board)
      coordinates = verify_submission(get_input, 2, level)
    end
    coordinates
  end
  
  def new_submission_valid(length, coordinates, board)
    if length == 3 && check_fleet(length, coordinates, board)
      puts SHIPS_OVERLAP
      return false
    elsif check_compliance(length, coordinates) == :valid
      coordinates
    else
      puts check_compliance(length, coordinates)
      puts RE_ENTER
      return false
    end
  end

  def check_compliance(length, coordinates)
    coordinates.pop if coordinates.length == 3
    coordinates = coordinates.join.split('')
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
    # binding.pry
    check = board.interpolate_coordinates(length, coordinates)

    check.any? do |check|
      board.fleet.values.flatten.include?(check)
    end

  end

  def ship_too_long(length, coordinates)
    # binding.pry
    (coordinates[3].ord - coordinates[1].ord) >= length || 
    (coordinates[2].ord - coordinates[0].ord) >= length
  end

  def ship_too_short(length, coordinates)
    !((coordinates[3].ord - coordinates[1].ord) == (length-1) || 
    (coordinates[2].ord - coordinates[0].ord) == (length-1))
  end

  def ship_wraps_board(coordinates)
    coordinates[1].ord > coordinates[3].ord || 
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


  def outside_grid(coordinates, level)
    coordinates.all? do |coordinate|
      GRID_SIZE[level][0].include?(coordinate.split('')[0]) &&
      GRID_SIZE[level][1].include?(coordinate.split('')[1])
    end
  end

  def get_input
    gets.chomp.upcase.split(' ')
  end
 
end