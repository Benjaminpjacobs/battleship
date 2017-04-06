require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'

require "./test/board_test.rb"
require "./test/computer_test.rb"
require "./test/end_game_test.rb"
require "./test/fleet_builder_test.rb"
require "./test/player_test.rb"
require "./test/session_test.rb"
require "./test/shot_sequence_test.rb"
require "./test/battleship_test.rb"

