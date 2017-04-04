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
    game_loop
    game_end_sequence
  end

  def game_loop
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
  end

  def game_end_sequence
    game_time = calculate_game_time
    turns = @player.moves.uniq.length
    winner =  determine_winner
    `say -v Ralph "GAME OVER, #{winner} wins."`
    end_message(turns, winner, game_time)
    puts NEW_GAME
  end

  def get_player_fleet
    puts GET_PLAYER_FLEET
    unit_submission(2, TWO_UNIT_SHIP)
    unit_submission(3, THREE_UNIT_SHIP)
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
  

  def unit_submission(size, message)
    puts message
    submission = verify_submission(get_input, 2)
    coordinates = placement_compliance(size, submission, @player.board)
    @player.board.add_ship(size, coordinates)
  end

end