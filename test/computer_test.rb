require './test/test_helper'
require './lib/computer.rb'
require 'pry'

class ComputerTest < Minitest::Test
  def test_it_exists
    c = Computer.new
    assert_instance_of Computer, c
  end
  def test_it_has_board
    c = Computer.new
    assert c.board
  end
  def test_it_has_moves
    c = Computer.new
    assert c.moves
  end
  def test_it_can_generate_one_coordinate
    c = Computer.new
    coordinate = c.generate_coordinate.split('')
    assert ("A".."D").to_a.include?(coordinate[0])
    assert ("1".."4").to_a.include?(coordinate[1])
  end
  def test_it_can_generate_potential_ship
    c = Computer.new
    actual = c.generate_potential_ship.length
    expected = 2
    assert_equal expected, actual
  end

  def test_it_can_check_first_compliance
    c = Computer.new
    ship = c.generate_potential_ship
    assert c.placement_compliance(2, ship)
  end

  def test_it_can_add_ship_to_fleet
    c = Computer.new
    ship = c.placement_compliance(2, c.generate_potential_ship)
    c.add_to_fleet(2, ship)
    actual = c.board.fleet
    expected = {2 => ship}
    assert_equal expected, actual
  end
  
  def test_it_can_check_second_compliance
    c = Computer.new
    ship = c.placement_compliance(2, c.generate_potential_ship)
    c.add_to_fleet(2, ship)
    ship = c.placement_compliance(3, c.generate_potential_ship)
    c.add_to_fleet(3, ship)
    assert c.compliant?(3, ship)
  end

  def test_it_can_make_fleet
    c = Computer.new
    c.make_fleet
    actual = c.board.fleet.keys
    expected = [2,3]
    assert_equal expected, actual
  end

  def test_it_makes_and_stores_moves
    c = Computer.new
    c.guess
    c.guess
    c.guess
    assert_equal 3, c.moves.length
  end

  def test_it_cannot_repeat_move
    c = Computer.new
    c.moves = ["A1", "A2", "A3", "A4", 
               "B1", "B2", "B3", "B4",
               "C1", "C2", "C3", "C4", 
               "D1", "D2", "D3"]
    c.guess
    actual = c.moves.pop
    expected = "D4"
    assert_equal expected, actual
  end
end