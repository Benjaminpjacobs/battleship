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
    if offensive_player.is_a?(Computer)
      evaluate_target(offensive_player.guess)
    else
      evaluate_target(shot_prompt)
    end
  end

  def shot_prompt
    defensive_player.show_board
    puts TARGET_PROMPT
    verify_submission(offensive_player.guess, 1).join
  end

  def evaluate_target(coordinate)
    status = defensive_player.board.evaluate_move(coordinate)
    if status == "  H  "
      sunk?(coordinate)
    elsif status == "  M  "
      miss_message(coordinate)
    else
      reinitiate_shot
    end
  end

  def reinitiate_shot
    if offensive_player.is_a?(Computer)
      evaluate_target(offensive_player.guess)
    elsif offensive_player.is_a?(Player)
      puts PICK_ANOTHER
      evaluate_target(shot_prompt)
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
      `say -v Ralph "You sunk my #{ship}-unit ship!"`
    else
      puts "I sunk your #{ship}-unit ship!"
      `say -v Ralph "I sunk your #{ship}-unit ship!"`
    end
  end

  def update_defensive_fleet(coordinate)
    ship = defensive_player.fleet.find{ |k,v| v.include?(coordinate)}
    defensive_player.fleet[ship[0]].delete(coordinate)
  end

end