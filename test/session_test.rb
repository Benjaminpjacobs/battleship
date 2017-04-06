require './test/test_helper'
require './lib/player'
require './lib/computer'
require './lib/session'
require './lib/messages'
require './lib/repl'
require './lib/end_game'

class SessionTest < Minitest::Test
  include Messages


  def setup
    @s = Session.new(:beginner)
  end

  def test_it_exists
    assert_instance_of Session, @s
  end

  def test_it_records_start_time
    actual = @s.start_time.strftime("%H:%M:%S")
    expected = Time.now.strftime("%H:%M:%S")
    assert_equal expected, actual
  end
  
  def test_it_starts_with_player_and_computer
    assert_instance_of Player, @s.player
  end

  def test_it_can_add_ships
    puts ''
    puts 'PUT A1 A2 then B1 B3'
    puts ''
    @s.get_player_fleet
    actual = @s.player.board.fleet
    expected = {2=>["A1", "A2"], 3=>["B1", "B3", "B2"]}
    assert_equal expected, actual
  end

  def test_ship_rules
    actual =  @s.check_compliance(2, ["A1","A3"])
    expected = SHIP_TOO_LONG_OR_SHORT 
    assert_equal expected, actual
    actual = @s.check_compliance(2, ["A1","C1"])
    expected = SHIP_TOO_LONG_OR_SHORT 
    assert_equal expected, actual
    actual = @s.check_compliance(3, ["A4","A1"]) 
    expected = SHIP_CANNOT_WRAP
    assert_equal expected, actual
    actual =  @s.check_compliance(3, ["C2","A2"]) 
    expected = SHIP_CANNOT_WRAP
    assert_equal expected, actual
    actual = @s.check_compliance(2, ["A1","B2"])
    expected = CANNOT_BE_DIAGONAL
    assert_equal expected, actual
    actual = @s.check_compliance(3, ["A1","A2","A3"])
    expected = SHIP_TOO_LONG_OR_SHORT
    assert_equal expected, actual
    actual = @s.check_compliance(2, ["A1", "A2"])
    expected = :valid
    assert_equal expected, actual
  end
  
  def test_verify_submission
    puts ''
    puts 'PUT A1 A2'
    puts ''
    actual = @s.verify_submission(["A1", "A5"], 2)
    expected = ["A1", "A2"]
    assert_equal expected, actual
  end

  def test_placement_compliance
    puts ''
    puts 'PUT A1 A2'
    puts ''
    actual = @s.placement_compliance(2, ["A1", "B2"], @s.player.board)
    expected = ["A1", "A2"]
    assert_equal expected, actual
  end

  def test_game_end
    computer = Computer.new(:beginner, Repl.new)
    player = Player.new(:beginner, Repl.new)
    @s.end_game(player, computer, Time.now)
  end

  def test_winner?
    assert @s.winner?
  end

  def test_game_loop
    computer = Computer.new(:beginner, Repl.new)
    player = Player.new(:beginner, Repl.new)
    player.fleet[1] = ["A1"]
    computer.fleet[1] = ["A1"]
    assert_nil @s.game_loop(player, computer)
  end


end
