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
    assert_instance_of Player, ss.player
    assert_instance_of Computer, ss.computer
  end

  # def test_shot_prompt
  #   ss = ShotSequence.new(@player, @computer)
  #   actual = ss.shot_prompt
  #   expected = "C2"
  #   assert_equal expected, actual
  # end
  
  # def test_evaluate_hit
  #   ss = ShotSequence.new(@player, @computer)
  #   coordinate = ss.shot_prompt
  #   actual = ss.evaluate_target(coordinate, @computer)
  #   expected = "Direct hit at C2!"
  #   assert_equal expected, actual
  # end

  # def test_evaluate_miss
  #   ss = ShotSequence.new(@player, @computer)
  #   coordinate = ss.shot_prompt
  #   actual = ss.evaluate_target(coordinate, @computer)
  #   expected = "Miss at A2!"
  #   assert_equal expected, actual
  # end

  # def test_updates_computer_fleet
  #   ss = ShotSequence.new(@player, @computer)
  #   coordinate = ss.shot_prompt
  #   ss.evaluate_target(coordinate, @computer)
  #   actual = @computer.board.fleet
  #   expected = {2 => ["A1","B1"], 3 => ["B2", "D2"]}
  #   assert_equal expected, actual
  # end

  # def test_it_knows_when_a_ship_is_sunk
  #   ss = ShotSequence.new(@player, @computer)
  #   ss.evaluate_target("B2", @computer)
  #   ss.evaluate_target("C2", @computer)
  #   coordinate = ss.shot_prompt
  #   actual = ss.evaluate_target(coordinate, @computer)
  #   expected = "You sunk my 3-unit ship!"
  #   assert_equal expected, actual
  # end

  # def test_it_knows_when_a_ship_is_sunk
  #   ss = ShotSequence.new(@player, @computer)
  #   ss.evaluate_target("B2", @computer)
  #   ss.evaluate_target("C2", @computer)
  #   ss.evaluate_target("A1", @computer)
  #   coordinate = ss.shot_prompt
  #   assert_nil ss.evaluate_target(coordinate, @computer)
  #   # expected = "You sunk my 2-unit ship!"
  #   # assert_equal expected, actual
  # end

  def test_cannot_hit_same_target_twice
    ss = ShotSequence.new(@player, @computer)
    ss.evaluate_target("A1", @computer)
    assert_nil ss.evaluate_target("A1", @computer)
  end

  # def test_computer_shot
  #   ss = ShotSequence.new(@player, @computer)
  #   actual = ss.evaluate_target(@computer.guess, @player)
  #   assert_instance_of String, actual
  # end

  # def test_computer_sink
  #   ss = ShotSequence.new(@player, @computer)
  #   ss.evaluate_target(@computer.guess, @player)
  #   ss.evaluate_target(@computer.guess, @player)
  #   ss.evaluate_target(@computer.guess, @player)
    # binding.pry
    # assert_instance_of String, actual
  # end
end
