task default: %w[test]

task :test do
  ruby "./test/battleship_test.rb"
  ruby "./test/board_test.rb"
  ruby "./test/player_test.rb"
  ruby "./test/session_test.rb"
end  