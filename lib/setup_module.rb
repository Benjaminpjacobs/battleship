module Setup
  
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
end