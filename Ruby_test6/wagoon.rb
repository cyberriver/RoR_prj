$LOAD_PATH << '.'
require 'producer.rb'

class Wagoon
  include Producer
  attr_accessor :wagoon_type,:wagoon_name

  def initialize()
    puts "выберите тип вагона"
    puts "1 - вагон грузовой"
    puts "2 - вагон пассажирский"
    @wagoon_type = gets.chomp.to_i

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

  private
  def validate!
    raise "Вы ввели не существующий тип вагона" unless [1, 2].include?(@wagoon_type)
  end

end
