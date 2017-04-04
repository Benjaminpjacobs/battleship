require './test/test_helper'
require './lib/battleship.rb'

class BattleshipTest < Minitest::Test
  def test_it_exists
    b = Battleship.new
    assert_instance_of Battleship, b
  end

  def test_welcome
    b = Battleship.new
    assert_nil b.welcome
  end

  def test_instructions
    b = Battleship.new
    assert_nil b.instructions 
  end

  def test_quit
    b = Battleship.new
    actual = b.quit_message
    expected = ''
    assert_equal expected, actual
  end

  def test_battleship
    b = Battleship.new
    actual = b.play_battleship
    assert_instance_of Session, actual
  end

  def test_menu
    b = Battleship.new
    puts " "
    puts "check loop from i back to q".upcase
    puts " "
    actual = b.menu
    expected = ''
    assert_equal expected, actual
  end
end