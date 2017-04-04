require './lib/setup_module'
require './lib/messages'
require 'pry'

class ShotSequence
  include Setup, Messages
  attr_accessor :offensive_player, :defensive_player

  def initialize(offensive_player, defensive_player)
    @offensive_player, @defensive_player = offensive_player, defensive_player 
  end

  def new_turn
    defensive_player.show_board if offensive_player.is_a?(Player)
    shot_loop(offensive_player)
    return
  end


  def evaluate_target(coordinate)
    status = defensive_player.evaluate_move(coordinate)
    if status == "  H  "
      sunk?(coordinate)
    elsif status == "  M  "
      miss_message(coordinate)
    else
      "reinitiate_shot"
    end
  end

  def reinitiate_shot
    puts PICK_ANOTHER if offensive_player.is_a?(Player)
    shot_loop(offensive_player)
    return
  end

  def shot_loop(offensive_player)
    if evaluate_target(offensive_player.guess).nil? 
      return
    else
     reinitiate_shot
    end
  end

  def hit_message(coordinate)
    update_defensive_fleet(coordinate)
    defensive_player.show_board
    puts direct_hit(coordinate)
  end

  def miss_message(coordinate)
    defensive_player.show_board
    puts miss(coordinate)
  end

  def sunk?(coordinate)
    if ship = defensive_player.fleet.key([coordinate])
      update_defensive_fleet(coordinate)
      defensive_player.show_board
      sunk_message(ship, defensive_player)
    else
      hit_message(coordinate)
    end
  end

  def sunk_message(ship, defensive_player)
    if defensive_player.is_a?(Computer)
      puts "You sunk my #{ship}-unit ship!"
    elsif defensive_player.is_a?(Player)
      puts "I sunk your #{ship}-unit ship!"
    end
  end

  def update_defensive_fleet(coordinate)
    ship = defensive_player.fleet.find{ |k,v| v.include?(coordinate)}
    defensive_player.fleet[ship[0]].delete(coordinate)
  end

end