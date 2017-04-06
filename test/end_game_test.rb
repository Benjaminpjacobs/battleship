require './test/test_helper'
require './lib/computer'
require './lib/player'
require './lib/end_game'
require './lib/repl'

class EndGameTest < Minitest::Test

  def setup
    @player = Player.new(:beginner, Repl.new)
    @player.moves << "A2"
    @computer = Computer.new(:beginner, Repl.new)
    @start_time = Time.new(2017, 04, 05)
  end

  def test_it_exists
    eg = EndGame.new(@player, @computer, @start_time)
    assert_instance_of EndGame, eg
  end  

  def test_determine_winner
    eg = EndGame.new(@player, @computer, @start_time)
    actual = eg.determine_winner
    expected = "Player"
    assert_equal expected, actual
  end

  def test_determine_winner_computer
    p = Player.new(:beginner, Repl.new)
    c = Computer.new(:beginner, Repl.new)
    p.moves << "A2"
    c.moves << "D1"
    eg = EndGame.new(p, c, @start_time)
    actual = eg.determine_winner
    expected = "Computer"
    assert_equal expected, actual
  end

  def test_calculate_game_time
    eg = EndGame.new(@player, @computer, @start_time) 
    assert_instance_of String, eg.calculate_game_time
  end

  def test_run
    eg = EndGame.new(@player, @computer, @start_time) 
    assert_instance_of Array, eg.run
  end
end