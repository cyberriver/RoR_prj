$LOAD_PATH << '.'
require 'producer.rb'

class Wagoon
  include Producer
  attr_accessor :wagoon_type,:wagoon_name

  def initialize(type, par)
    @wagoon_type = type
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

  def sit_down
    @wagoon_name
  end

  private
  def validate!
    raise "Вы ввели не существующий тип вагона" unless [1, 2].include?(@wagoon_type)
  end
end
