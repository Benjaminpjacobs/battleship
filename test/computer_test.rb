require './test/test_helper'
require './lib/computer'
require './lib/repl'
require 'pry'

class ComputerTest < Minitest::Test

  def setup
    @comp = Computer.new(:beginner, Repl.new )
  end

  def test_it_exists
    assert_instance_of Computer, @comp
  end

  def test_it_has_board
    assert @comp.board
  end
  
  def test_it_has_moves
    assert @comp.moves
  end

  def test_it_can_generate_one_coordinate

    coordinate = @comp.generate_coordinate.split('')
    assert ("A".."D").to_a.include?(coordinate[0])
    assert ("1".."4").to_a.include?(coordinate[1])
  end

  def test_it_can_generate_potential_ship
    actual = @comp.generate_potential_ship.length
    expected = 2
    assert_equal expected, actual
  end

  def test_generate_ship_large
    @comp = Computer.new(:advanced, Repl.new)
    actual = @comp.generate_potential_ship.length
    expected = 2
    assert_equal expected, actual
  end
  
  def test_it_can_check_compliance
    assert @comp.computer_compliant?(2, ["A1", "A2"])
    refute @comp.computer_compliant?(2, ["A1", "A3"])
    assert @comp.computer_compliant?(3, ["A1", "A3", "A2"])
    assert @comp.computer_compliant?(4, ["A1","A4","A2","A3"])
  end

  def test_it_can_add_ship_to_fleet
    @comp.add_to_fleet(2, ["A1", "A2"])
    actual = @comp.board.fleet
    expected = {2 => ["A1", "A2"]}
    assert_equal expected, actual
  end
  
  def test_it_checks_fleet_for_later_compliance
    @comp.fleet[2] = ["A1", "A2"]
    refute @comp.validate_ship(3, ["A1", "A3"])
    
  end

  def test_it_can_make_fleet
    @comp.make_fleet
    actual = @comp.board.fleet.keys
    expected = [2,3]
    assert_equal expected, actual
  end

  def test_it_can_make_fleet_inter
    @comp = Computer.new(:intermediate, Repl.new)
    @comp.make_fleet
    actual = @comp.board.fleet.keys
    expected = [2,3,4]
    assert_equal expected, actual
  end


  def test_it_can_make_fleet_adv
    @comp = Computer.new(:advanced, Repl.new)
    @comp.make_fleet
    actual = @comp.board.fleet.keys
    expected = [2,3,4,5]
    assert_equal expected, actual
  end

  def test_it_makes_and_stores_moves
    @comp.guess
    @comp.guess
    @comp.guess
    assert_equal 3, @comp.moves.length
  end

  def test_combine_double_digits
    @comp = Computer.new(:advanced, Repl.new)
    actual = @comp.combine_double_digits(["F","1","0", "C","1","1"])
    expected = ["F", "10", "C", "11"]
    assert_equal expected, actual
    actual = @comp.combine_double_digits(["H","1","L","1","0"])
    expected = ["H", "1", "L", "10"]
    assert_equal expected, actual
    actual = @comp.combine_double_digits(["G","1","2","L","9"])
    expected = ["G", "12", "L", "9"]
    assert_equal expected, actual
    actual = @comp.combine_double_digits(["L","1","2","K","9"])
    expected = ["L", "12", "K", "9"]
    assert_equal expected, actual
  end 
  

end