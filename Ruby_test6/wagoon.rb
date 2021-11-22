$LOAD_PATH << '.'
require 'producer.rb'
require 'validator.rb'

class Wagoon
  include Producer
  include Validator
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


end
