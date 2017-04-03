require "./lib/player"
require "./lib/computer"
require "./lib/setup_module"
require "./lib/shot_sequence"
require 'pry'

class Session
  include Setup
  attr_reader :start_time, :player, :computer
  def initialize
    @start_time = Time.now
    @player = Player.new
    @computer = Computer.new
    @computer.make_fleet
  end
  
  def game_flow
    get_player_fleet
    loop do 
      puts "=========== "
      puts "Player Turn:"
      ShotSequence.new(@player, @computer).new_turn
      break if end_of_game?
      puts "--press return to continue--"
      sleep until gets.chomp == ''
      puts "=========== "
      puts "Computer Turn:"
      ShotSequence.new(@computer, @player).new_turn
      break if end_of_game?
      puts "--press return to continue--"
      sleep until gets.chomp == ''
    end
    game_over
  end

  def game_over
    game_time = calculate_game_time
    winner =  if @player.moves.uniq.length > @computer.moves.uniq.length
                "Player"
              else
                "Computer"
              end
    turns = @player.moves.uniq.length
    puts "==========="
    puts "GAME - OVER"
    puts "Game Stats:"
    puts "Winner: #{winner} "
    puts "TurnCount: #{turns}"
    puts "GameTime: #{game_time}seconds"
  end

  def calculate_game_time
    ((@time.min * 60) + @time.sec)
  end
  def end_of_game?
    @computer.fleet.values.flatten.empty? || @player.fleet.values.flatten.empty?
  end
  
  def get_player_fleet
    puts "I have laid out my ships on the grid.
          You now need to layout your two ships.
          The first is two units long and the
          second is three units long.
          The grid has A1 at the top left and 
          D4 at the bottom right."
    two_unit_submission
    three_unit_submission
  end



private
  def two_unit_submission
    puts "Enter the squares for the two-unit ship:"
    submission = verify_submission(gets.chomp.split(' '), 2)

    coordinates = placement_compliance(2, submission, @player.board)
    @player.board.add_ship(2, coordinates)
  end

  def three_unit_submission
    puts "Enter the squares for the three-unit ship:"
    submission = verify_submission(gets.chomp.split(' '), 2)

    coordinates = placement_compliance(3, submission, @player.board)
    @player.board.add_ship(3, coordinates)
  end

end