require "./lib/board.rb"
require "./lib/setup_module.rb"
require "./lib/messages.rb"

class Player
  include Setup, Messages
  attr_accessor :board, :moves
  def initialize
    @board = Board.new
    @board.setup
    @moves = []
  end
  
  def show_board
    @board.display_board
  end

  def fleet
    @board.fleet
  end

  def add_ship(size, coordinates)
    @board.add_ship(size, coordinates)
  end

  def evaluate_move(coordinate)
    @board.evaluate_move(coordinate)
  end

  def guess
    puts TARGET_PROMPT
    @moves << gets.chomp.upcase
    submission = @moves.last.split(' ')
    verify_submission(submission, 1).join
  end

end