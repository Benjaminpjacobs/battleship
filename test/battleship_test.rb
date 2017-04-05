require './test/test_helper'
require './lib/battleship.rb'
require './lib/messages'

class BattleshipTest < Minitest::Test
  include Messages

  def test_it_exists
    b = Battleship.new
    assert_instance_of Battleship, b
  end

  def test_welcome
    b = Battleship.new
    assert_equal WELCOME, b.welcome
  end

  def test_instructions
    b = Battleship.new
    assert_equal INSTRUCTIONS, b.instructions 
  end

  def test_quit
    b = Battleship.new
    assert_equal QUITTER, b.quit_message
  end

  def test_choose_level
    b= Battleship.new
    expected = :beginner
    actual = b.choose_level
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
    assert_nil b.menu
  end
end