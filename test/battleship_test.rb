require './test/test_helper'
require './lib/battleship.rb'

class BattleshipTest < Minitest::Test
  def test_it_exists
    b = Battleship.new
    assert_instance_of Battleship, b
  end
  def test_battleship_menu
    b = Battleship.new
    expected = nil
    actual = b.menu
    assert_equal expected, actual
  end
  def test_instructions
    b = Battleship.new
    actual = b.instructions
    expected = nil
    assert_equal expected, actual  
  end
  def test_quit
    b = Battleship.new
    actual = b.quit_message
    assert_nil actual
  end
  def test_battleship
    b = Battleship.new
    actual = b.play_battleship
    assert_nil actual
  end
  def test_response
    b = Battleship.new
    assert b.response
  end
end