require "./lib/board.rb"
require "./lib/compliance_module"
require "./lib/messages.rb"
require "./lib/repl.rb"

class Player
  include ComplianceMod, Messages
  attr_accessor :board, :moves, :interface

  def initialize(level=:beginner)
    @board = Board.new
    @board.setup(level)
    @moves = []
    @interface = Repl.new
    @level = level
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
    interface.display(TARGET_PROMPT)
    @moves << interface.get.upcase
    submission = @moves.last.split(' ')
    verify_submission(submission, 1, @level).join
  end

end