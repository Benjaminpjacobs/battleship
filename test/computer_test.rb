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
end