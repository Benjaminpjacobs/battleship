require './lib/compliance_module'
require './lib/messages'

class FleetBuilder
  include ComplianceMod

  attr_accessor :level, :user, :interface

  FLEET_LEVEL = { beginner: 3, intermediate: 4, advanced: 5}

  def initialize(level, user, interface)
    @level = level
    @user = user
    @interface = interface
  end

  def build
    user.display_board
    for i in (2..FLEET_LEVEL[level])
      interface.display(UNIT_SHIP[i])
      submission = interface.get.upcase.split(' ')
      unit_submission(i, submission)
      system 'clear'
      user.display_board
    end
  end
  
  def unit_submission(size, submission)
    submission = verify_submission(submission, 2, level)
    coordinates = placement_compliance(size, submission, user.board, level)
    user.add_ship(size, coordinates)
  end
  
end