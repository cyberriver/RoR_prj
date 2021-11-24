$LOAD_PATH << '.'
require 'wagoon.rb'
class Passenger_wagoon < Wagoon

  attr_reader :free_space, :busy_space

  def initialize(type, par)
    @wagoon_type = type
    @wagoon_name = "вагон пассажирский"
    @free_space = par
    @busy_space = 0
  end

  def fill_space
    @free_space -=1
    @busy_space +=1
  end
end
