module BoardMaker
  INDEX_TO_LETTERS = {
    2 => "  A  ",  3 => "  B  ",  4 => "  C  ", 5 => "  D  ",
    6 => "  E  ",  7 => "  F  ",  8 => "  G  ", 9 => "  H  ",   
    10 => "  I  ", 11 => "  J  ", 12=> "  K  ", 13 => "  L  "
  }

  SIZE = {
    beginner: [7,5],
    intermediate: [11,9],
    advanced: [15,13]
  }

  def make_board(level)
    board = Array.new(SIZE[level][0]){Array.new(SIZE[level][1], '     ')}
    header_and_footer(board)
    fill_in_top_row(board)
    fill_in_side(board)
    board
  end

  def header_and_footer(board)
    board[0].map!{|space| space = "====="} 
    board[-1].map!{|space| space = "====="} 
  end

  def fill_in_top_row(board)
    for i in (0..board[1].length-1)
      if i.zero?
        board[1][0] = "  .  "
      else
        board[1][i] = "  #{i}  "
      end
    end
  end

  def fill_in_side(board)
    board.each_with_index do |line, index|
      if index.zero? || index == 1 || index == (board.length-1)
        next
      else
        board[index][0] = INDEX_TO_LETTERS[index]
      end
    end
  end
end