require "./lib/board.rb"

class Player
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

  def guess
    @moves << gets.chomp.upcase
    @moves.last
  end
end