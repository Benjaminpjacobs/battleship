require './test/test_helper'
require './lib/session.rb'

class SessionTest < Minitest::Test
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

  # def test_it_can_prompt_player_for_fleet
  #   s = Session.new
  #   s.get_player_fleet
  #   s.player.board.display_board
  #   actual = s.player.board.fleet
  #   expected = {2=>["A1", "A2"], 3=>["B1", "B3", "B2"]}
  #   assert_equal expected, actual
  # end

  # def test_ship_rules
  #   s = Session.new
  #   actual =  s.check_compliance(2, ["A1","A3"])
  #   expected = "Coordinates must correspond to the first and last units of the ship. (IE: You can’t place a two unit ship at “A1 A3”)"
  #   assert_equal expected, actual
  #   actual = s.check_compliance(2, ["A1","C1"])
  #   expected = "Coordinates must correspond to the first and last units of the ship. (IE: You can’t place a two unit ship at “A1 A3”)"
  #   assert_equal expected, actual
  #   actual = s.check_compliance(3, ["A4","A1"]) 
  #   expected = "Ships cannot wrap around the board"
  #   assert_equal expected, actual
  #   actual =  s.check_compliance(3, ["C2","A2"]) 
  #   expected = "Ships cannot wrap around the board"
  #   assert_equal expected, actual
  #   actual = s.check_compliance(2, ["A1","B2"])
  #   expected = "Ships must be horizontal or vertical"
  #   assert_equal expected, actual
  #   actual = s.check_compliance(2, ["A1", "A2"])
  #   expected = :valid
  #   assert_equal expected, actual
  # end
  
  # def test_placement_compliance
  #   s = Session.new
  #   actual = s.placement_compliance(2, ["A1", "B2"], s.player.board)
  #   expected = ["A1", "A2"]
  #   assert_equal expected, actual
  # end

  # def test_game_end_sequence
  #   s = Session.new
  #   s.game_end_sequence
  # end

  def test_session_game_flow
    s = Session.new
    s.game_flow
  end

end
