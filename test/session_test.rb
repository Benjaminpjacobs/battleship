require './test/test_helper'
require './lib/session.rb'
require './lib/computer'
require './lib/player'
require './lib/messages'

class SessionTest < Minitest::Test
  include Messages
  def test_it_exists
    s = Session.new
    assert_instance_of Session, s
  end

  def test_it_records_start_time
    s = Session.new
    actual = s.start_time.strftime("%H:%M:%S")
    expected = Time.now.strftime("%H:%M:%S")
    assert_equal expected, actual
  end
  
  def test_it_starts_with_player_and_computer
    s = Session.new
    assert_instance_of Player, s.player
  end

  def test_it_can_add_ships
    s = Session.new
    s.get_player_fleet
    actual = s.player.board.fleet
    expected = {2=>["A1", "A2"], 3=>["B1", "B3", "B2"]}
    assert_equal expected, actual
  end

  def test_ship_rules
    s = Session.new
    actual =  s.check_compliance(2, ["A1","A3"])
    expected = SHIP_TOO_LONG_OR_SHORT 
    assert_equal expected, actual
    actual = s.check_compliance(2, ["A1","C1"])
    expected = SHIP_TOO_LONG_OR_SHORT 
    assert_equal expected, actual
    actual = s.check_compliance(3, ["A4","A1"]) 
    expected = SHIP_CANNOT_WRAP
    assert_equal expected, actual
    actual =  s.check_compliance(3, ["C2","A2"]) 
    expected = SHIP_CANNOT_WRAP
    assert_equal expected, actual
    actual = s.check_compliance(2, ["A1","B2"])
    expected = CANNOT_BE_DIAGONAL
    assert_equal expected, actual
    actual = s.check_compliance(3, ["A1","A2","A3"])
    expected = SHIP_TOO_LONG_OR_SHORT
    assert_equal expected, actual
    actual = s.check_compliance(2, ["A1", "A2"])
    expected = :valid
    assert_equal expected, actual
  end
  
  def test_verify_submission
    s = Session.new
    actual = s.verify_submission(["A1", "A5"], 2)
    expected = ["A1", "A2"]
    assert_equal expected, actual
  end

  def test_placement_compliance
    s = Session.new
    actual = s.placement_compliance(2, ["A1", "B2"], s.player.board)
    expected = ["A1", "A2"]
    assert_equal expected, actual
  end

  def test_game_end
    computer = Computer.new
    player = Player.new
    s = Session.new
    s.end_game(player, computer, Time.now)
  end

  # def test_session_game_flow
  #   s = Session.new
  #   s.game_flow
  # end

end
