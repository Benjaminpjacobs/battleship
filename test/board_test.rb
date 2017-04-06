require './test/test_helper'
require './lib/board'
require './lib/repl'

class BoardTest < Minitest::Test

  def setup
    @board = Board.new(Repl.new)
  end

  def test_it_exists
    assert_instance_of Board, @board
  end

  def test_it_initializes_with_grid
    assert_instance_of Array, @board.board
  end

  def test_it_can_display_board
    actual = @board.display_board
    expected = []
    assert_equal expected, actual
  end

  def test_it_can_setup_default_display
    @board.setup
    actual = @board.board
    expected = [["=====", "=====", "=====", "=====", "====="], 
                ["  .  ", "  1  ", "  2  ", "  3  ", "  4  "], 
                ["  A  ", "     ", "     ", "     ", "     "], 
                ["  B  ", "     ", "     ", "     ", "     "], 
                ["  C  ", "     ", "     ", "     ", "     "],
                ["  D  ", "     ", "     ", "     ", "     "], 
                ["=====", "=====", "=====", "=====", "====="]]
    assert_equal expected, actual
  end
  
  def test_it_can_setup_intermediate_display
    @board.setup(:intermediate)
    actual = @board.board.length
    expected = 11
    assert_equal expected, actual
    @board.display_board
  end

  def test_it_can_setup_intermediate_display
    @board.setup(:advanced)
    actual = @board.board.length
    expected = 15
    assert_equal expected, actual
    @board.display_board
  end

  def test_it_can_record_hit
    @board.setup
    @board.hit("A3")
    actual = @board.board[2][3]
    expected = "  H  "
    assert_equal expected, actual
  end

  def test_it_can_record_hit
    @board.setup
    @board.hit("A3")
    @board.miss("D4")
    actual = @board.board[-2][4]
    expected = "  M  "
    assert_equal expected, actual
  end

  def test_it_can_add_ships
    @board.setup
    @board.add_ship(2, ["A1","A2"] )
    @board.add_ship(3, ["B3","D3"] )
    actual = @board.fleet
    expected = { 2 => ["A1","A2"], 3 => ["B3","D3", "C3"] }
    assert_equal expected, actual
  end

  def test_it_can_add_three_ship_horizontal
    @board.setup
    @board.add_ship(2, ["B2","B3"] )
    @board.add_ship(3, ["A1","A3"] )
    actual = @board.fleet
    expected = { 2 => ["B2","B3"], 3 => ["A1","A3","A2"] }
    assert_equal expected, actual
  end

  def test_it_knows_a_hit
    @board.setup
    @board.add_ship(2, ["B2","B3"] )
    @board.add_ship(3, ["A1","A3"] )
    @board.evaluate_move("A2")
    expected = "  H  "
    actual = @board.board[2][2]
    assert_equal expected, actual
    @board.display_board
  end

  def test_it_knows_a_miss
    @board.setup
    @board.add_ship(2, ["B2","B3"] )
    @board.add_ship(3, ["A1","A3"] )
    @board.evaluate_move("A4")
    expected = "  M  "
    actual = @board.board[2][4]
    assert_equal expected, actual
    @board.display_board
  end

  def test_it_can_put_ships_on_the_board
    @board.setup
    @board.add_ship(2, ["B2","B3"] )
    @board.add_ship(3, ["A1","A3"] )
    actual = @board.board[2][1]
    expected = "  ∆  "
    assert_equal expected, actual
  end

  def test_hit_or_miss_already?
    @board.setup
    @board.add_ship(2, ["B2","B3"] )
    @board.add_ship(3, ["A1","A3"] )
    @board.evaluate_move("A4")
    assert_equal false, @board.evaluate_move("A4")
    @board.evaluate_move("C2")
    assert_equal false, @board.evaluate_move("C2")
  end
  
  def test_interpolate_coordinates
    refute @board.interpolate_coordinates(5, ["K12", "C10"])
    refute @board.interpolate_coordinates(5, ["K9", "C12"])
    refute @board.interpolate_coordinates(5, ["K12", "C10"])
  end
end
