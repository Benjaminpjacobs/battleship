require "./lib/player"
class Session
  attr_reader :start_time, :player, :computer
  def initialize
    @start_time = Time.now.strftime("%H:%M:%S")
    @player = Player.new
    @computer = '' #Computer.new
  end
  def play_game
    
  end
end