require "./lib/board.rb"

class Player
  attr_accessor :board, :moves
  def initialize
    @board = Board.new
    @board.setup
    @moves = []
  end
  
  def guess
    puts "Where would you like to shoot?"
    coordinate = gets.chomp
    if @moves.include?(coordinate)
      puts "You've already shot there"
      guess
    else
      @moves << coordinate
    end
    coordinate
  end
end