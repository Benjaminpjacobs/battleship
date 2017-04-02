require './test/test_helper'
require './lib/computer.rb'
require 'pry'

class ComputerTest < Minitest::Test
  def test_it_exists
    c = Computer.new
    assert_instance_of Computer, c
  end
end