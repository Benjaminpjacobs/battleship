require "./lib/player"
require "./lib/computer"
require "./lib/setup_module"
require "./lib/shot_sequence"
require "./lib/messages"
require 'pry'

class Session
  include Setup, Messages
  attr_reader :start_time, :player, :computer

  def initialize
    @start_time = Time.now
    @player = Player.new
    @computer = Computer.new
  end
  
  def game_flow
    @computer.make_fleet
    get_player_fleet
    game_loop(@player, @computer)
    game_end_sequence
  end

  def get_player_fleet(largest_ship=3)
    puts GET_PLAYER_FLEET
    add_ships(largest_ship, @player)
  end

  def game_loop(offense, defense)
    turn = 1
    loop do 
      puts which_player(turn=1)
      ShotSequence.new(offense, defense).new_turn
      break if winner?
      offense, defense = defense, offense
      turn += 1
      sleep until return_to_continue
    end
  end

  def game_end_sequence
    game_time = calculate_game_time
    turns = @player.moves.uniq.length
    winner =  determine_winner
    `say -v Ralph "GAME OVER, #{winner} wins."`
    end_message(turns, winner, game_time)
    puts NEW_GAME
  end

private

  def return_to_continue
    puts RETURN_MESSAGE
    if gets.chomp == ''
      return true 
    else
      return_to_continue
    end
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

  def winner?
    @computer.fleet.values.flatten.empty? || @player.fleet.values.flatten.empty?
  end

  def unit_submission(size, submission, user)
    submission = verify_submission(submission, 2)
    coordinates = placement_compliance(size, submission, user.board)
    user.add_ship(size, coordinates)
  end

  def add_ships(largest_ship, user)
    for i in (2..largest_ship)
      puts UNIT_SHIP[i]
      submission = get_input
      unit_submission(i, submission, user)
    end
  end

end