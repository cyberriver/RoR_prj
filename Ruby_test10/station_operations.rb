# frozen_string_literal: true
module StationOperations
  STATION_MENU =
    '
  Выберите раздел
  1 - создать станцию
  2 - просмотреть все доступные станции
  3 - просмотреть количество поездов на станции
  4 - показать все поезда на станции
  0 - вернуться в предыдущее меню'

  def station_menu
    puts STATION_MENU
    loop do
      case gets.chomp.to_i
      when 1 then create_station
      when 2 then display_station
      when 3 then count_trains
      when 4 then display_trains_on_station
      when 0 then break
      else
        puts 'вы ввели некорректное значение'
      end
    end
  end

  def create_station
    print 'введите имя новой станции: '
    @stations.push(Station.new(gets.chomp.to_s))
    puts "log: создана станция #{@stations.last.station_name}"
    puts STATION_MENU
  rescue RuntimeError => e
    puts "log:#{e.message}"
    retry
  end

  def display_station
    Station.all
    puts STATION_MENU
  end

  def count_trains
    puts 'пжл-та выберите номер станции'
    puts 'для которой посмотреть количество поездов'
    display_station
    print 'номер станции: '
    i = gets.chomp.to_i
    puts "log: #{i}"
    @stations[i].count_train
    puts STATION_MENU
  end

  def display_trains_on_station
    my_proc = proc { |x| puts x }
    Station.all
    puts 'выберите станцию'
    i = gets.chomp - 1
    @stations[i].block_call(my_proc)
  end

  def display_station?
    puts 'список всех станций'
    i = 0
    @stations.each do |value|
      puts "#{i}.#{value.station_name}"
      i += 1
    end
  end
end
