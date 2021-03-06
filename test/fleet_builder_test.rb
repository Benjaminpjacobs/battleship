require './test/test_helper'
require './lib/fleet_builder'
require './lib/player'
require './lib/repl'

class FleetBuilderTest < Minitest::Test
  
  def setup
    @user = Player.new(:beginner, Repl.new)
    @fb = FleetBuilder.new(:beginner, @user, Repl.new)
  end

  def test_it_exists
    assert_instance_of FleetBuilder, @fb
  end

  def test_unit_submission
    @fb.unit_submission(2, ["A1", "A2"])
    expected = {2=>["A1", "A2"]}
    actual = @user.fleet
    assert_equal expected, actual
  end

  def test_build
    puts ''
    puts "Put A1 A2, Then B1 B3"
    puts ''
    @fb.build
    expected = {2=>["A1", "A2"], 3=> ["B1", "B3", "B2"]}
    actual = @user.fleet
    assert_equal expected, actual
  end
end