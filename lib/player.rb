require "./lib/board.rb"

class Player
  attr_accessor :board, :turn
  def initialize
    @board = Board.new
    @board.setup
    @turn = 0
  end
end