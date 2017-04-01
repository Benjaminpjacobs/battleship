require './test/test_helper'
require './lib/session.rb'

class SessionTest < Minitest::Test
  def test_it_exists
    s = Session.new
    assert_instance_of Session, s
  end
  def test_it_records_start_time
    s = Session.new
    actual = s.start_time
    expected = Time.now.strftime("%H:%M:%S")
    assert_equal expected, actual
  end
  def test_it_starts_with_player_and_computer
    s = Session.new
    assert_instance_of Player, s.player
  end
  def test_it_can_prompt_player_for_fleet
    s = Session.new
    s.get_player_fleet
  end
end
