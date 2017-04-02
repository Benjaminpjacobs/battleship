module Setup
  
  def placement_compliance(length, coordinates, board)
    if length == 3 && check_fleet(length, coordinates, board)
      puts "Ships cannot overlap"
      puts "please choose new coordinates"
      submission = verify_submission(gets.chomp.split(' '))
      placement_compliance(length, submission, board)
    elsif compliant?(length, coordinates) == :valid
      coordinates
    else
      puts compliant?(length, coordinates)
      puts "please choose new coordinates"
      submission = verify_submission(gets.chomp.split(' '))
      placement_compliance(length, submission, board)
    end
  end

  def compliant?(length, coordinates)
    coordinates.pop if coordinates.length == 3
    coordinates = coordinates.join.split('')
    if ship_too_long(length, coordinates) 
      "Coordinates must correspond to the first and last units of the ship. (IE: You can’t place a two unit ship at “A1 A3”)"
    elsif ship_wraps_board(coordinates)
      "Ships cannot wrap around the board"
    elsif ship_too_short(length, coordinates) || same_coordinates(coordinates)
      "Coordinates must correspond to the first and last units of the ship. (IE: You can’t place a two unit ship at “A1 A3”)"
    elsif ship_diagonal(coordinates)
      "Ships must be horizontal or vertical"
    else
      :valid
    end
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

  def check_fleet(length, coordinates, board)
    check = board.interpolate_coordinates(coordinates)
    (board.fleet.values.flatten.include?(check[0]) || board.fleet.values.flatten.include?(check[1]) ||
    board.fleet.values.flatten.include?(check[2]))
  end

  def verify_submission(submission)
    if submission.length != 2 
      puts "Please enter two coordinates separated by a space.(i.e A1 A2 for 2 unit ship or B1 B3 for three unit ship)"
      verify_submission(gets.chomp.split(' '))
    elsif !outside_grid(submission)
      puts "Please enter two coordinates that are within the selected grid size"
      verify_submission(gets.chomp.split(' '))
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
  
 
end