require 'pry'
require './lib/messages'
require './lib/repl'

class EndGame
  include Messages 
  def initialize(player, computer, start_time)
    @player = player
    @computer = computer
    @start_time = start_time
  end
  
  def run
    game_time = calculate_game_time
    turns = @player.moves.uniq.length
    winner =  determine_winner
    stats= Array.new.push(game_time, turns, winner)
  end

  def determine_winner
    if @player.moves.uniq.length > @computer.moves.uniq.length
      "Player"
    else
      "Computer"
    end
  end

  def calculate_game_time
    if delta > 60
      x = (delta/60).to_i ; y = (delta%60).to_i
    else
      x = 0 ; y = delta.to_i
    end
    "#{x} minutes, #{y} seconds"
  end

  def delta
    Time.now - @start_time
  end

end