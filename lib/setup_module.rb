require './lib/messages'
module Setup
  include Messages
  
  def placement_compliance(length, coordinates, board)
    if length == 3 && check_fleet(length, coordinates, board)
      puts SHIPS_OVERLAP
      new_submission(length, board)
    elsif check_compliance(length, coordinates) == :valid
      coordinates
    else
      puts check_compliance(length, coordinates)
      puts RE_ENTER
      new_submission(length, board)
    end
  end

  def new_submission(length, board)
    submission = verify_submission(get_input, 2)
    placement_compliance(length, submission, board)
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

  def ship_too_long(length, coordinates)
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

  def check_fleet(length, coordinates, board)
    check = board.interpolate_coordinates(coordinates)
    (board.fleet.values.flatten.include?(check[0]) || 
    board.fleet.values.flatten.include?(check[1]) ||
    board.fleet.values.flatten.include?(check[2]))
  end

  def verify_submission(submission, expected_length)
    if submission.length != expected_length 
      puts IMPROPER_INPUT
      verify_submission(get_input, expected_length)
    elsif !outside_grid(submission)
      puts OUTSIDE_GRID
      verify_submission(get_input, expected_length)
    else
      submission
    end
  end
  
  def outside_grid(coordinates)
    coordinates.all? do |coordinate|
      ("A".."D").to_a.include?(coordinate.split('')[0]) &&
      ("1".."4").to_a.include?(coordinate.split('')[1])
    end
  end

  def get_input
    gets.chomp.upcase.split(' ')
  end
 
end