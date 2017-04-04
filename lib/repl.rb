class Repl
  def display(message)
    puts message
  end

  def say(message)
    `say -v Ralph "#{message}"`
  end
  
  def get
    gets.chomp
  end
end