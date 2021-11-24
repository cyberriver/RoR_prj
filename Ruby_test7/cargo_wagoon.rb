$LOAD_PATH << '.'
require 'wagoon.rb'

class Cargo_wagoon < Wagoon

  attr_reader :free_volume, :busy_volume

  def initialize(type, par)
    @wagoon_type = type
    @wagoon_name = "вагон грузовой"
    @free_volume = par
    @busy_volume = 0
  end

  def fill_volume(volume)
    @free_volume -=volume
    @busy_volume +=volume
  end
end
