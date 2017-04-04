require "./lib/compliance_module"

class Repl
  include ComplianceMod
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