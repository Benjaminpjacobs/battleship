require './test/test_helper'
require './lib/player'
require './lib/board'
require './lib/computer'
require './lib/shot_sequence'
require './lib/repl'

class ShotSequenceTest < Minitest::Test

  def setup
    @interface = Repl.new
    @player = Player.new(:beginner,@interface )
    @player.board.add_ship(2, ["A1","A2"])
    @player.board.add_ship(3, ["A4", "C4"])

    @computer = Computer.new(:beginner, @interface)
    @computer.add_to_fleet(2, ["A1","B1"])
    @computer.add_to_fleet(3, ["B2", "D2"])
    
    @ss = ShotSequence.new(@player, @computer,:beginner, @interface)
  end

  def test_it_exists
    assert_instance_of ShotSequence, @ss
  end

  def test_it_accepts_player_and_computer_as_vars
    assert_instance_of Player, @ss.offensive_player
    assert_instance_of Computer, @ss.defensive_player
  end
  
  def test_evaluate_hit
    assert_equal "Direct hit at C2!", @ss.evaluate_target("C2")
  end

  def test_evaluate_miss
    assert_equal "Miss at A2!", @ss.evaluate_target("A2")
  end

  def test_updates_computer_fleet
    @ss.evaluate_target("C2")
    actual = @computer.board.fleet
    expected = {2 => ["A1","B1"], 3 => ["B2", "D2"]}
    assert_equal expected, actual
  end

  def test_it_knows_when_a_ship_is_sunk
    @ss.evaluate_target("B2")
    @ss.evaluate_target("C2")
    actual = @ss.evaluate_target("D2")
    expected = "You sunk my 2-unit ship!"
    assert_equal expected, actual
  end

  def test_it_knows_when_a_ship_is_sunk
    @ss.evaluate_target("B2")
    @ss.evaluate_target("C2")
    @ss.evaluate_target("A1")
    actual = @ss.evaluate_target("B1")
    expected = "You sunk my 2-unit ship!"
    assert_equal expected, actual
  end

  def test_cannot_hit_same_target_twice
    @ss.evaluate_target("A1")
    refute @ss.evaluate_target("A1")
  end

  def test_computer_shot
    ss = ShotSequence.new(@computer, @player, :beginner, @interface)
    actual = ss.evaluate_target(@computer.guess)[0..7]
    expected = "Miss at "
    assert_equal expected, actual
  end

  def test_new_turn
    puts "choose A2"
    actual = @ss.new_turn
    expected = "Miss at A2!"
    assert_equal expected,  actual
  end

  def test_new_turn_computer
    assert = @ss.new_turn.is_a?(String)
  end
end
