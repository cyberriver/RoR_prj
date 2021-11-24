$LOAD_PATH << '.'
require 'producer.rb'

class Wagoon
  include Producer
  attr_accessor :wagoon_type,:wagoon_name
  attr_reader :free_space, :busy_space

  def initialize(type, par)
    @wagoon_type = type
    @free_space = par
    @busy_space=0
    case @wagoon_type
    when 1 then @wagoon_name = "вагон пассажирский"
    when 2 then @wagoon_name = "вагон грузовой"
    else
      validate!
    end
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  def fill_wagoon(volume)
    @free_space -= volume
    @busy_space += volume
  end

  private

  def validate!
    raise "Вы ввели не существующий тип вагона" unless [1, 2].include?(@wagoon_type)
  end
end
