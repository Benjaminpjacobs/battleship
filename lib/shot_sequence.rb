require './lib/compliance_module'
require './lib/messages'
require './lib/repl'

class ShotSequence
  include ComplianceMod, Messages
  attr_accessor :offensive_player, :defensive_player, :interface, :level

  def initialize(offensive_player, defensive_player, level, interface)
    @offensive_player, @defensive_player = offensive_player, defensive_player 
    @level = level
    @interface = interface
  end

  def new_turn
    defensive_player.display_board if offensive_player.is_a?(Player)
    shot_loop(offensive_player)
  end

  def evaluate_target(coordinate)
    status = defensive_player.evaluate_move(coordinate)
    if status == '  H  '
      sunk?(coordinate)
    elsif status == '  M  '
      miss_message(coordinate)
    else
      return false
    end
  end

  def reinitiate_shot
    interface.display(PICK_ANOTHER) if offensive_player.is_a?(Player)
    shot_loop(offensive_player)
  end

  def shot_loop(offensive_player)
    message = evaluate_target(offensive_player.guess)
    if message == false
      reinitiate_shot
    else
     message
    end
  end

  def hit_message(coordinate)
    update_defensive_fleet(coordinate)
    defensive_player.display_board
    direct_hit(coordinate)
  end

  def miss_message(coordinate)
    defensive_player.display_board
    miss(coordinate)
  end

  def sunk?(coordinate)
    if ship = defensive_player.fleet.key([coordinate])
      update_defensive_fleet(coordinate)
      defensive_player.display_board
      sunk_message(ship, defensive_player)
    else
      hit_message(coordinate)
    end
  end

  def sunk_message(ship, defensive_player)
    if defensive_player.is_a?(Computer)
      "You sunk my #{ship}-unit ship!"
    elsif defensive_player.is_a?(Player)
      "I sunk your #{ship}-unit ship!"
    end
  end

  def update_defensive_fleet(coordinate)
    ship = defensive_player.fleet.find{ |k,v| v.include?(coordinate)}
    defensive_player.fleet[ship[0]].delete(coordinate)
  end

end