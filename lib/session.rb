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
    loop do 
      puts PLAYER_TURN
      ShotSequence.new(@player, @computer).new_turn
      break if winner?
      sleep until return_to_continue
      puts COMPUTER_TURN
      ShotSequence.new(@computer, @player).new_turn
      break if winner?
      sleep until return_to_continue
    end
    game_end_sequence
  end

  def return_to_continue
    puts RETURN_MESSAGE
    if gets.chomp == ''
      return true 
    else
      return_to_continue
    end
  end

  def game_end_sequence
    game_time = calculate_game_time
    turns = @player.moves.uniq.length
    winner =  determine_winner
    `say -v Ralph "GAME OVER, #{winner} wins."`

    end_message(turns, winner, game_time)
  end

  def determine_winner
    if @player.moves.uniq.length > @computer.moves.uniq.length
      "Player"
    else
      "Computer"
    end
  end

  def calculate_game_time
    delta = (Time.now - @start_time)
    if delta > 60
      x = (delta/60).to_i
      y = (delta%60).to_i
    else
      x = 0
      y = delta.to_i
    end
    "#{x} minutes, #{y} seconds"
  end

  def winner?
    @computer.fleet.values.flatten.empty? || @player.fleet.values.flatten.empty?
  end
  
  def get_player_fleet
    puts GET_PLAYER_FLEET
    two_unit_submission
    three_unit_submission
  end

private
  def two_unit_submission
    puts TWO_UNIT_SHIP
    submission = verify_submission(gets.chomp.upcase.split(' '), 2)

    coordinates = placement_compliance(2, submission, @player.board)
    @player.board.add_ship(2, coordinates)
  end

  def three_unit_submission
    puts THREE_UNIT_SHIP
    submission = verify_submission(gets.chomp.upcase.split(' '), 2)

    coordinates = placement_compliance(3, submission, @player.board)
    @player.board.add_ship(3, coordinates)
  end

end