require "./test/test_helper"
require "./lib/repl"
require "./lib/player"

class PlayerTest < Minitest::Test

  def setup
    @p = Player.new(:beginner, Repl.new )
  end

  def test_it_exists
    assert_instance_of Player, @p
  end
  
  def test_it_defaults_with_a_board
    actual = @p.board.board
    expected = [["=====", "=====", "=====", "=====", "====="], 
                ["  .  ", "  1  ", "  2  ", "  3  ", "  4  "], 
                ["  A  ", "     ", "     ", "     ", "     "], 
                ["  B  ", "     ", "     ", "     ", "     "], 
                ["  C  ", "     ", "     ", "     ", "     "], 
                ["  D  ", "     ", "     ", "     ", "     "], 
                ["=====", "=====", "=====", "=====", "====="]]
    assert_equal expected, actual
  end

  def test_it_defaults_with_zero_moves
    actual = @p.moves.length
    expected = 0
    assert_equal expected, actual
  end

  def test_player_can_make_move
    @p.guess
    actual = @p.moves
    expected = ["A1"]
    assert_equal expected, actual
  end

end