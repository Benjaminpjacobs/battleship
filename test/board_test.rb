require './test/test_helper'
require './lib/board.rb'

class BoardTest < Minitest::Test
  def test_it_exists
    b = Board.new
    assert_instance_of Board, b
  end

  def test_it_initializes_with_grid
    b = Board.new
    assert_instance_of Array, b.board
  end

  def test_it_can_display_board
    b = Board.new
    actual = b.display_board
    expected = []
    assert_equal expected, actual
  end

  def test_it_can_setup_default_display
    b = Board.new
    b.setup
    actual = b.board
    expected = [["==", "==", "==", "==", "=="], 
              [". ", "1 ", "2 ", "3 ", "4 "], 
              ["A ", "  ", "  ", "  ", "  "], 
              ["B ", "  ", "  ", "  ", "  "], 
              ["C ", "  ", "  ", "  ", "  "],
              ["D ", "  ", "  ", "  ", "  "], 
              ["==", "==", "==", "==", "=="]]
    assert_equal expected, actual
  end
  def test_it_can_record_hit
    b = Board.new
    b.setup
    b.hit("A3")
    actual = b.board[2][3]
    expected = "H "
    assert_equal expected, actual
  end

  def test_it_can_record_hit
    b = Board.new
    b.setup
    b.hit("A3")
    b.miss("D4")
    actual = b.board[-2][4]
    expected = "M "
    assert_equal expected, actual
  end

  def test_it_can_add_ships
    b = Board.new
    b.add_ship(2, ["A1","A2"] )
    b.add_ship(3, ["B3","D3"] )
    actual = b.fleet
    expected = { 2 => ["A1","A2"], 3 => ["B3","D3","C3",] }
    assert_equal expected, actual
  end

  def test_it_can_add_three_ship_horizontal
    b = Board.new
    b.add_ship(2, ["B2","B3"] )
    b.add_ship(3, ["A1","A3"] )
    actual = b.fleet
    expected = { 2 => ["B2","B3"], 3 => ["A1","A3","A2"] }
    assert_equal expected, actual
  end

  def test_it_knows_a_hit
    b = Board.new
    b.setup
    b.add_ship(2, ["B2","B3"] )
    b.add_ship(3, ["A1","A3"] )
    b.evaluate_move("A2")
    expected = "H "
    actual = b.board[2][2]
    assert_equal expected, actual
    b.display_board
  end

  def test_it_knows_a_miss
    b = Board.new
    b.setup
    b.add_ship(2, ["B2","B3"] )
    b.add_ship(3, ["A1","A3"] )
    b.evaluate_move("A4")
    expected = "M "
    actual = b.board[2][4]
    assert_equal expected, actual
    b.display_board
  end
end