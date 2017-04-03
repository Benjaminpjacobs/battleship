require './lib/setup_module'
require 'pry'

class ShotSequence
  include Setup
  attr_accessor :offensive_player, :defensive_player

  def initialize(offensive_player, defensive_player)
    @offensive_player, @defensive_player  = offensive_player, defensive_player 
  end

  def new_turn
    if offensive_player.is_a?(Computer)
      evaluate_target(offensive_player.guess)
    else
      move = shot_prompt
      evaluate_target(move)
    end
  end

  def shot_prompt
    defensive_player.show_board
    puts ''
    puts "Please enter a target"
    verify_submission(offensive_player.guess.split(' '), 1).join
  end

  def evaluate_target(coordinate)
    status = defensive_player.board.evaluate_move(coordinate)
    if status == "H "
      sunk?(coordinate)
    elsif status == "M "
      miss_message(coordinate)
    else
      reinitiate_shot
    end
  end

  def reinitiate_shot
    if offensive_player.is_a?(Computer)
      evaluate_target(offensive_player.guess)
    elsif offensive_player.is_a?(Player)
      puts "You have already tried that location"
      new_shot = verify_submission(offensive_player.guess.split(' '), 1).join
      evaluate_target(new_shot)
    end
  end

  def hit_message(coordinate)
    update_defensive_fleet(coordinate)
    defensive_player.show_board
    puts "Direct hit at #{coordinate}!"
    "Direct hit at #{coordinate}!"
  end

  def miss_message(coordinate)
    defensive_player.show_board
    puts "Miss at #{coordinate}!"
    "Miss at #{coordinate}!"
  end

  def sunk?(coordinate)
    if ship = defensive_player.fleet.key([coordinate])
      update_defensive_fleet(coordinate)
      defensive_player.show_board
      puts "You sunk my #{ship}-unit ship!"
      "You sunk my #{ship}-unit ship!"
    else
      hit_message(coordinate)
    end
  end

  def update_defensive_fleet(coordinate)
    ship = defensive_player.fleet.find{ |k,v| v.include?(coordinate)}
    defensive_player.fleet[ship[0]].delete(coordinate)
  end

end