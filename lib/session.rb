require "./lib/player"
require "./lib/computer"
require "./lib/compliance_module"
require "./lib/shot_sequence_alt"
require "./lib/messages"
require "./lib/repl"
require 'pry'

class Session
  include ComplianceMod, Messages
  attr_accessor :start_time, :player, :computer, :interface

  FLEET_LEVEL = { beginner: 3, intermediate: 4, advanced: 5}

  def initialize(level=:beginner)
    @start_time = Time.now
    @player = Player.new(level)
    @computer = Computer.new(level)
    @interface = Repl.new
    @level = level
  end
  
  def game_flow
    @computer.make_fleet
    binding.pry
    get_player_fleet(FLEET_LEVEL[@level])
    game_loop(@player, @computer)
    game_end_sequence
  end

  def get_player_fleet(level=:beginner)
    interface.display(GET_PLAYER_FLEET)
    add_ships(FLEET_LEVEL[level], @player)
  end

  def game_loop(offense, defense)
    turn = 1
    loop do 
      interface.display(which_player(turn))
      ShotSequence.new(offense, defense, @level).new_turn
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
  end

private

  def return_to_continue
    interface.display(RETURN_MESSAGE)
    if interface.get == ''
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

  def unit_submission(size, submission, user, level)
    submission = verify_submission(submission, 2, @level)
    coordinates = placement_compliance(size, submission, user.board, @level)
    user.add_ship(size, coordinates)
  end

  def add_ships(level=:beginner, user)
    user.show_board
    for i in (2..level)
      interface.display(UNIT_SHIP[i])
      submission = interface.get.upcase.split(' ')
      unit_submission(i, submission, user, @level)
      user.show_board
    end
  end

end