module Messages
  WELCOME = 
  "=================== Welcome to BATTLESHIP ===================
Would you like to (p)lay, read the (i)nstructions, or (q)uit?"

  QUITTER = 
"You'll never sink my battleship with THAT attitude!"


  INSTRUCTIONS = 
"The object of Battleship is to try and sink all of 
the computers ships before it sinks all of yours. 
You try and hit them by typing the coordinates of 
one of the squares on the board.  The computer will 
also try to hit your ships by 'calling' out coordinates. 
Since you cannot see the computer's board you must 
try to guess where the ships are.

Each player places the 2 ships somewhere on their 
board.  The ships can only be placed vertically 
or horizontally. Diagonal placement is not allowed. 
No part of a ship may hang off the edge of the board. 
Ships may not overlap each other.  No ships may be 
placed on another ship. You and the computer will 
take turns guessing coordinates. Either a hit or miss 
message will be displayed as appropriate and recorded 
on your board. 
    
When all of the squares that one your ships occupies 
have been hit, the ship will be sunk. As soon as all 
of one player's ships have been sunk, the game ends.

Would you like to (p)lay, or (q)uit?"

  GET_PLAYER_FLEET = 
"I have laid out my ships on the grid.
You now need to layout your two ships.
The first is two units long and the
second is three units long.
The grid has A1 at the top left and 
D4 at the bottom right.

"
  TWO_UNIT_SHIP = 
"Enter the squares for the two-unit ship:"

  THREE_UNIT_SHIP =
"Enter the squares for the three-unit ship:"
  
  PLAYER_TURN =
"=========== 
Player Turn:"

  COMPUTER_TURN =
"=========== 
Computer Turn:"

  RETURN_MESSAGE = 
"--press return to continue--"

  SHIP_TOO_LONG_OR_SHORT =
"Coordinates must correspond to the first and last units of the ship. (IE: You can’t place a two unit ship at “A1 A3”)"

  SHIP_CANNOT_WRAP =
"Ships cannot wrap around the board"

  CANNOT_BE_DIAGONAL = 
"Ships must be horizontal or vertical"

  IMPROPER_INPUT = 
"Please enter two coordinates separated by a space.(i.e A1 A2 for 2 unit ship or B1 B3 for three unit ship):"

  OUTSIDE_GRID = 
"Please enter two coordinates that are within the selected grid size:"

  RE_ENTER = 
"please choose new coordinates:"

  SHIPS_OVERLAP = 
"Ships cannot overlap
please choose new coordinates:"

  TARGET_PROMPT = 
"
Please enter a target:"

  PICK_ANOTHER = 
"You have already tried that location"

  def end_message(turns, winner, game_time)
      puts "=============================="
      puts "         GAME OVER            "
      puts "        Game Stats:           "
      puts "       TurnCount: #{turns}    "
      puts "      Winner: #{winner}       "
      puts "GameTime: #{game_time}        "
  end

  def direct_hit(coordinate)
    "Direct hit at #{coordinate}!"
  end

  def miss(coordinate)
    "Miss at #{coordinate}!"
  end
end
