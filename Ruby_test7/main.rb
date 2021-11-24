class Main
  require_relative  'station.rb'
  require_relative  'trains.rb'
  require_relative  'routes.rb'
  require_relative  'cargo_train.rb'
  require_relative  'passenger_train.rb'
  require_relative  'wagoon.rb'
  attr_accessor :stations,:trains,:routes,:wagoons

  INSTRUCTIONS =
  '
  Выберите раздел
  1 - операции со станциями
  2 - операции с поездами
  3 - операции с вагонами
  4 - операции с маршрутами
  0 - выйти'
  STATION_MENU =
  '
  Выберите раздел
  1 - создать станцию
  2 - просмотреть все доступные станции
  3 - просмотреть количество поездов на станции
  4 - показать все поезда на станции
  0 - вернуться в предыдущее меню'
  ROUTES_MENU =
  '
  Выберите раздел
  1 - создать маршрут
  2 - добавить\удалить станцию к маршруту
  3 - отобразить доступные машруты
  4 - посмотреть список станций в маршруте
  0 - вернуться в предыдущее меню'
  TRAIN_MENU =
  '
  Выберите раздел
  1 - создать поезд
  2	- добавить вагон
  3 - удалить вагон
  4 - просмотреть все поезда
  5 - назначить маршрут поезду
  6 - поехать по маршруту
  7 - вернуться назад по маршруту
  0 - вернуться в предыдущее меню'
  WAGOON_MENU =
  '
  Выберите раздел
  1 - создать вагон
  2 - просмотреть все вагоны
  0 - вернуться в предыдущее меню'

  def initialize
	  @stations = []
	  @trains = []
	  @routes = []
    @wagoons = []
    @producer =[]
    puts INSTRUCTIONS
  end

  def start
    loop do
      action = gets.chomp.to_i
      case action
      when 1 then #операции со станциями
        puts STATION_MENU
        a2 = gets.chomp.to_i
        loop do
          case a2
          when 1 then self.create_station
          when 2 then self.display_station
          when 3 then self.count_trains
          when 4 then self.display_trains_on_station
          when 0 then break
          else
            puts "вы ввели некорректное значение"
          end
          a2 = gets.chomp.to_i
        end
      when 2 then # операции  поездами
        puts TRAIN_MENU
        a2 = gets.chomp.to_i
        loop do
          case a2
          when 1 then self.create_train
          when 2 then self.add_wagoon
          when 3 then self.delete_wagoon
          when 4 then self.display_train
          when 5 then self.set_route
          when 6 then self.move_on
          when 7 then self.move_back
          when 0 then break
          else
            puts "вы ввели некорректное значение"
          end
          a2 = gets.chomp.to_i
        end
      when 3 then # операции с вагонами
        puts WAGOON_MENU
        a2 = gets.chomp.to_i
        loop do
          case a2
          when 1 then self.create_wagoon
          when 2 then self.display_wagooROUTESn
          when 0 then break
          else
            puts "вы ввели некорректное значение"
          end
          a2 = gets.chomp.to_i
        end
      when 4 then #операции с маршрутами
        puts ROUTES_MENU
        a2 = gets.chomp.to_i
        loop do
          case a2
          when 1 then self.create_route
          when 2 then self.change_route
          when 3 then self.display_route
          when 4 then self.display_route_stations
          when 0 then break
          else
            puts "вы ввели некорректное значение"
          end
          a2 = gets.chomp.to_i
        end
      when 0 then break
      else
        puts "вы ввели некорректное значение"
      end
      puts "                    "
      puts INSTRUCTIONS
    end
  end

  private #методы, которые используются внутри других методов
  def display_route_stations
    self.display_route?
    print "пжл-та выберите маршрут"
    i = gets.chomp.to_i
    k = 1
    @routes[i].station_list.each do |value|
      puts "#{k}. #{value.station_name}"
      k +=1
    end
    puts ROUTES_MENU
  end

  def create_station
    print "введите имя новой станции: "
    @stations.push(Station.new(gets.chomp.to_s))
    puts "log: создана станция #{@stations.last.station_name}"
    puts STATION_MENU
  rescue RuntimeError=>e
    puts "log:#{e.message}"
    retry
  end

  def display_station
    Station.all
    puts STATION_MENU
  end

  def count_trains
    puts "пжл-та выберите номер станции"
    puts "для которой посмотреть количество поездов"
    self.display_station
    print "номер станции: "
    i = gets.chomp.to_i
    puts "log: #{i}"
    @stations[i].count_train
    puts STATION_MENU
  end

  def create_route
    puts "Чтобы создать маршрут выберите номер начальной и конечной станции"
    self.display_station?
    print "выберите название маршрута: "
    n = gets.chomp.to_s
    print "выберите номер начальной станции: "
    b = gets.chomp.to_i
    print "выберите номер конечной станции: "
    e = gets.chomp.to_i
    @routes.push(Route.new(n,@stations[b],@stations[e]))
    puts "Создан маршрут #{@route_name}"
    puts "начальная станция: #{@stations[b].station_name}, конечная станция: #{@stations[e].station_name} "
    puts ROUTES_MENU
  rescue RuntimeError=>e
    puts "log:#{e.message}"
    retry
  end

  def display_route
    puts "список маршрутов"
    i = 0
    @routes.each do |value|
      puts "#{i}.#{value.route_name}"
      i +=1
    end
    puts ROUTES_MENU
  end

  def change_route
    puts "Выберите номер маршрута, который хотите поменять"
    self.display_route?
    print "Выберите номер: "
    i = gets.chomp.to_i
    puts "выберите действие 1 - добавить станцию, 2 - удалить "
    action = gets.chomp.to_i
    case action
    when 1 then
      puts "выберите номер станции, которую добавить"
      self.display_station?
      k = gets.chomp.to_i
      @routes[i].add_station(@stations[k])
      puts ROUTES_MENU
    when 2 then
      puts "выберите номер станции которую удалить из маршрута"
      @routes[i].display
      k = gets.chomp.to_i
      @routes[i].delete(k)
      @routes[i].display
      puts ROUTES_MENU
    else
      puts "вы выбрали что-то непонятное"
    end
  end

  def display_trains_on_station
    my_proc = Proc.new {|x| puts x}
    Station.all
    puts "выберите станцию"
    i = gets.chomp-1
    @stations[i].block_call(my_proc)
  end

  def create_train
    puts "Выберите какой поезд создать"
    puts "1 - грузовой"
    puts "2 - пассажирский"
    print "тип поезда: "
    o = gets.chomp.to_i
    if o ==1
      begin
      puts "введите номер нового грузового поезда: "
      @trains.push(Cargo_train.new(gets.chomp.to_s))

      rescue RuntimeError=>e
        puts "log:#{e.message}"
        retry
      end

    elsif o ==2
      begin
      puts "введите номер нового пассажирского поезда: "
      @trains.push(Passenger_train.new(gets.chomp.to_s))
      rescue RuntimeError=>e
      puts "log:#{e.message}"
      retry
      end
    else
      puts "вы ввели что-то нето"
    end
    puts TRAIN_MENU
  end

  def add_wagoon
    self.display_train?
    print "Выберите номер поезда для изменения состава "
    i = gets.chomp.to_i
    puts "выберите вагон, который добавить"
    self.display_wagoon?
    k = gets.chomp.to_i
    @trains[i].add_wagoon(@wagoons[k])
    puts "вагон #{@wagoons[k].wagoon_name}добавлен "
    puts TRAIN_MENU
  end

  def delete_wagoon
    self.display_train?
    print "Выберите номер поезда для изменения состава "
    i = gets.chomp.to_i
    puts "выберите вагон, который отцепить"
    @trains[i].display_w
    k = gets.chomp.to_i
    @trains[i].delete(k)
    @trains[i].display
    puts TRAIN_MENU
  end

  def display_train
    puts "список всех поездов"
    i = 0
    @trains.each do |value|
      puts "#{i}.#{value.train_num}"
      i +=1
    end
    puts TRAIN_MENU
  end

  def count_train
    self.display_station
    print "выберите пжл-та станцию: "
    i=gets.chomp.to_i
    @stations[i].count_train
  end

  def set_route
    self.display_train?
    print "пжл-та выберите поезд"
    t = gets.chomp.to_i
    self.display_route?
    print "пжл-та выберите маршрут для назначения поезду"
    i=gets.chomp.to_i
    @trains[t].set_route(@routes[i])
    puts "поезду #{@trains[t].train_num} назначен маршрут #{@routes[i]}"
    puts TRAIN_MENU
  end

  def move_on
    self.display_train?
    print "пжл-та выберите поезд"
    t = gets.chomp.to_i
    @trains[t].go_on_route
    puts TRAIN_MENU
  end

  def move_back
    self.display_train?
    print "пжл-та выберите поезд"
    t = gets.chomp.to_i
    @trains[t].go_back_route
    puts TRAIN_MENU
  end

  def create_wagoon
    puts "выберите тип вагона"
    puts "1 - вагон грузовой"
    puts "2 - вагон пассажирский"
    type = gets.chomp.to_i
    case type
    when 1 then puts "укажите количество мест в вагоне"
      par = gets.chomp.to_i
    when 2 then puts "укажите объем грузового вагона"
      par = gets.chomp.to_i
    else raise "Вы ввели некорректное значение"
    end
    @wagoons.push(Wagoon.new(type,par))
  rescue RuntimeError=>e
    puts "log:#{e.message}"
    retry
  end

  def display_wagoon
    puts "список вагонов"
    i = 0
    @wagoons.each do |value|
      puts "#{i}.#{value.wagoon_name}"
      i +=1
    end
    puts WAGOON_MENU
  end

  def display_station?
    puts "список всех станций"
    i = 0
    @stations.each do |value|
      puts "#{i}.#{value.station_name}"
      i +=1
    end
  end

  def display_wagoon?
    puts "список всех вагонов"
    i = 0
    @wagoons.each do |value|
      puts "#{i}.#{value.wagoon_name}"
      i +=1
    end
  end

  def display_route?
    puts "список маршрутов"
    i = 0
    @routes.each do |value|
      puts "#{i}.#{value.route_name}"
      i +=1
    end
  end

  def display_train?
    puts "список всех поездов"
    i = 0
    @trains.each do |value|
      puts "#{i}.#{value.train_num}"
      i +=1
    end
  end
end
