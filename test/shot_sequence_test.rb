require './test/test_helper'
require './lib/player'
require './lib/board'
require './lib/computer'
require './lib/shot_sequence'
require 'pry'

class ShotSequenceTest < Minitest::Test

  def setup
    @player = Player.new
    @player.board.add_ship(2, ["A1","A2"])
    @player.board.add_ship(3, ["A4", "C4"])

    @computer = Computer.new
    @computer.add_to_fleet(2, ["A1","B1"])
    @computer.add_to_fleet(3, ["B2", "D2"])
    
  end

  def test_it_exists
    ss = ShotSequence.new(nil, nil)
    assert_instance_of ShotSequence, ss
  end

  def test_it_accepts_player_and_computer_as_vars
    ss = ShotSequence.new(@player, @computer)
    assert_instance_of Player, ss.offensive_player
    assert_instance_of Computer, ss.defensive_player
  end

  def test_shot_prompt
    ss = ShotSequence.new(@player, @computer)
    actual = ss.shot_prompt
    expected = "A1"
    assert_equal expected, actual
  end
  
  def test_evaluate_hit
    ss = ShotSequence.new(@player, @computer)
    assert_nil ss.evaluate_target("C2")

  end

  def test_evaluate_miss
    ss = ShotSequence.new(@player, @computer)
    assert_nil ss.evaluate_target("A2")
  end

  def test_updates_computer_fleet
    ss = ShotSequence.new(@player, @computer)
    ss.evaluate_target("C2")
    actual = @computer.board.fleet
    expected = {2 => ["A1","B1"], 3 => ["B2", "D2"]}
    assert_equal expected, actual
  end

  def test_it_knows_when_a_ship_is_sunk
    ss = ShotSequence.new(@player, @computer)
    ss.evaluate_target("B2")
    ss.evaluate_target("C2")
    # coordinate = ss.shot_prompt
    actual = ss.evaluate_target("D2")
    expected = ""
    assert_equal expected, actual
  end

  def test_it_knows_when_a_ship_is_sunk
    ss = ShotSequence.new(@player, @computer)
    ss.evaluate_target("B2")
    ss.evaluate_target("C2")
    ss.evaluate_target("A1")
    actual = ss.evaluate_target("B1")
    expected = ""
    assert_equal expected, actual
  end

  def test_cannot_hit_same_target_twice
    ss = ShotSequence.new(@player, @computer)
    ss.evaluate_target("A1")
    assert_nil ss.evaluate_target("A1")

  end

  def test_computer_shot
    ss = ShotSequence.new(@computer, @player)
    actual = ss.evaluate_target(@computer.guess)
    assert_nil actual
  end

  def test_new_turn
    ss = ShotSequence.new(@player, @computer)
    actual = ss.new_turn
    expected = "Miss at A2!"
    assert_nil actual
  end

  def test_new_turn_computer
    ss = ShotSequence.new(@computer, @player)
    assert = ss.new_turn.is_a?(String)
  end
end
