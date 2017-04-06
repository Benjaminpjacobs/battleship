require './lib/messages'

class Repl
  include Messages

  def display(message)
    puts message
  end

  def say(message)
    `say -v Ralph "#{message}"`
  end
  
  def get
    gets.chomp
  end

  def return_to_continue
    display(RETURN_MESSAGE)
    if get == ''
      return true 
    else
      return_to_continue
    end
  end

  def end_message(game_time, turns, winner)
      say ("GAME OVER, #{winner} wins.")
      puts "=============================="
      puts "         GAME OVER            "
      puts "        Game Stats:           "
      puts "       TurnCount: #{turns}    "
      puts "      Winner: #{winner}       "
      puts "GameTime: #{game_time}        "
      puts "  (p)lay again or (q)uit ?    "
  end

end