require "./test/test_helper.rb"
require "./lib/player.rb"

class PlayerTest < Minitest::Test
  def test_it_exists
    p = Player.new
    assert_instance_of Player, p
  end
  def test_it_defaults_with_a_board
    p = Player.new
    actual = p.board.board
    expected = [["==", "==", "==", "==", "=="], 
              [". ", "1 ", "2 ", "3 ", "4 "], 
              ["A ", "  ", "  ", "  ", "  "], 
              ["B ", "  ", "  ", "  ", "  "], 
              ["C ", "  ", "  ", "  ", "  "],
              ["D ", "  ", "  ", "  ", "  "], 
              ["==", "==", "==", "==", "=="]]
    assert_equal expected, actual
  end
  def test_it_defaults_with_zero_moves
    p = Player.new
    actual = p.moves.length
    expected = 0
    assert_equal expected, actual
  end
  def test_player_can_make_move
    p= Player.new
    p.guess
    actual = p.moves
    expected = ["A1"]
    assert_equal expected, actual
  end

  def test_player_cannot_make_same_move_twice
    p = Player.new
    p.moves << "A1"
    p.guess
    actual = p.moves
    expected = ["A1", "A2"]
    assert_equal expected, actual
  end
end