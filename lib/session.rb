require './lib/player'
require './lib/computer'
require './lib/compliance_module'
require './lib/shot_sequence'
require './lib/messages'
require './lib/repl'
require './lib/end_game'
require './lib/fleet_builder'

class Session
  include ComplianceMod, Messages
  attr_accessor :start_time, :player, :computer, :interface, :level

  def initialize(level=:beginner)
    @start_time = Time.now
    @interface = Repl.new
    @player = Player.new(level, @interface)
    @computer = Computer.new(level, @interface)
    @level = level
  end
  
  def game_flow
    system 'clear'
    computer.make_fleet
    get_player_fleet
    game_loop(player, computer)
    end_game(player, computer, start_time)
  end

  def get_player_fleet
    interface.display(GET_PLAYER_FLEET)
    FleetBuilder.new(level, player, interface).build
  end

  def game_loop(offense, defense)
    turn = 1
    loop do 
      system 'clear'
      interface.display(which_player(turn))
      result = ShotSequence.new(offense, defense, level, interface).new_turn
      interface.display(result)
      break if winner?
      offense, defense = defense, offense
      turn += 1
      sleep until interface.return_to_continue
    end
  end

  def end_game(player, computer, start_time)
     finish = EndGame.new(player, computer, start_time)
     stats = finish.run
     interface.end_message(stats[0], stats[1], stats[2])
  end

  def winner?
    computer.fleet.values.flatten.empty? || player.fleet.values.flatten.empty?
  end  
end