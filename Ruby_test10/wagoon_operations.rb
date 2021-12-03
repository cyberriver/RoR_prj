# frozen_string_literal: true
module WagoonOperations
  WAGOON_MENU =
    '
  Выберите раздел
  1 - создать вагон
  2 - просмотреть все вагоны у поезда
  0 - вернуться в предыдущее меню'

  def wagoon_menu
    puts WAGOON_MENU
    loop do
      case gets.chomp.to_i
      when 1 then create_wagoon
      when 2 then display_train_wagoon
      when 0 then break
      else
        puts 'вы ввели некорректное значение'
      end
    end
  end

  def fullfill_wagoon
    display_train?
    puts 'Выберите поезд'
    i = gets.chomp.to_i
    k = 0
    @trains[i].wagoons.each do |value|
      puts "#{k}.№ вагона #{value.object_id} тип вагона #{value.wagoon_name}"
      k += 1
    end
    puts 'Выберите вагон'
    k = gets.chomp.to_i
    case @trains[i].wagoons[k].wagoon_type
    when 1 then @trains[i].wagoons[k].fill_wagoon(1)
    when 2
      puts 'укажите помещаемый объем'
      volume = gets.chomp.to_i
      @trains[i].wagoons[k].fill_wagoon(volume)
      puts "доступное место в вагоне #{@trains[i].wagoons[k].free_space}"
      puts "занято в вагоне #{@trains[i].wagoons[k].busy_space}"
    else
      puts 'что-то не то с вагоном'
    end
    puts WAGOON_MENU
  end

  def create_wagoon
    puts 'выберите тип вагона'
    puts '1 - вагон пассажирский'
    puts '2 - вагон грузовой'
    type = gets.chomp.to_i
    case type
    when 1 then puts 'укажите количество мест в вагоне'
    when 2 then puts 'укажите объем грузового вагона'
    else raise 'Вы ввели некорректное значение'
    end
    par = gets.chomp.to_i
    @wagoons.push(Wagoon.new(type, par))
    puts WAGOON_MENU
  rescue RuntimeError => e
    puts "log:#{e.message}"
    retry
  end

  def display_train_wagoon
    i = 0
    @trains.each do |train|
      puts "#{i}.#{train.train_num}"
      i += 1
    end
    puts 'выберите пжлста поезд'
    i = gets.chomp.to_i
    @trains[i].wagoons.each do |value|
      puts "#{i}.#{value.object_id}#{value.wagoon_name}"
      i += 1
    end
    puts WAGOON_MENU
  end

  def display_wagoon?
    puts 'список всех вагонов'
    i = 0
    @wagoons.each do |value|
      puts "#{i}.№ вагона #{value.object_id}, тип вагона - #{value.wagoon_name}"
      i += 1
    end
  end
end
