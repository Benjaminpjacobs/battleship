require "./test/test_helper.rb"
require "./lib/player.rb"

class PlayerTest < Minitest::Test
  def test_it_exists
    p = Player.new
    assert_instance_of Player, p
  end
  def test_it_defaults_with_a_board
    p = Player.new
    actual = p.board
    expected = [["==", "==", "==", "==", "=="], 
              [". ", "1 ", "2 ", "3 ", "4 "], 
              ["A ", "  ", "  ", "  ", "  "], 
              ["B ", "  ", "  ", "  ", "  "], 
              ["C ", "  ", "  ", "  ", "  "],
              ["D ", "  ", "  ", "  ", "  "], 
              ["==", "==", "==", "==", "=="]]
    assert_equal expected, actual
  end
  def test_it_defaults_with_turn_count_zero
    p = Player.new
    actual = p.turn
    expected = 0
    assert_equal expected, actual
  end
end