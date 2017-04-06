require './lib/board.rb'
require './lib/compliance_module'
require './lib/messages.rb'
require './lib/repl.rb'
require 'forwardable'

class Player
  extend Forwardable
  include ComplianceMod, Messages
  attr_accessor :board, :moves, :interface
  
  def_delegators :@board, :display_board, :fleet, :add_ship, :evaluate_move

  def initialize(level=:beginner, interface)
    @interface = interface
    @board = Board.new(@interface)
    @board.setup(level)
    @moves = []
    @level = level
  end

  def guess
    interface.display(TARGET_PROMPT)
    @moves << interface.get.upcase
    submission = @moves.last.split(' ')
    verify_submission(submission, 1, @level).join
  end

end