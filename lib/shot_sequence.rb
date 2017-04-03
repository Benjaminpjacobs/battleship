require './lib/setup_module'
require 'pry'

class ShotSequence
  include Setup
  attr_accessor :player, :computer

  def initialize(player, computer)
    @player = player
    @computer = computer
  end

  def shot_prompt
    @computer.board.display_board
    puts ''
    puts "Please enter a target"
    verify_submission(@player.guess.split(' '), 1).join
  end

  def evaluate_target(coordinate, defensive_player)
    status = defensive_player.board.evaluate_move(coordinate)
    if status == "H "
      sunk?(coordinate, defensive_player)
    elsif status == "M "
      miss_message(coordinate, defensive_player)
    else
      reinitiate_shot(defensive_player)
    end
  end

  def reinitiate_shot(defensive_player)
    if defensive_player.is_a?(Player)
      evaluate_target(@computer.guess, @player)
    elsif defensive_player.is_a?(Computer)
      puts "You have already tried that location"
      new_shot = verify_submission(@player.guess.split(' '), 1).join
      evaluate_target(new_shot, @computer)
    end
  end

  def hit_message(coordinate, defensive_player)
    update_defensive_fleet(coordinate, defensive_player)
    defensive_player.board.display_board
    puts "Direct hit at #{coordinate}!"
  end

  def miss_message(coordinate, defensive_player)
    defensive_player.board.display_board
    puts "Miss at #{coordinate}!"
  end

  def sunk?(coordinate, defensive_player)
    if ship = defensive_player.board.fleet.key([coordinate])
      update_defensive_fleet(coordinate, defensive_player)
      puts "You sunk my #{ship}-unit ship!"
    else
      hit_message(coordinate, defensive_player)
    end
  end

  def update_defensive_fleet(coordinate, defensive_player)
    ship = defensive_player.board.fleet.find{ |k,v| v.include?(coordinate)}
    defensive_player.board.fleet[ship[0]].delete(coordinate)
  end

end