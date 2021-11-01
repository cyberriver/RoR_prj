=begin
Класс Station (Станция):

    Имеет название, которое указывается при ее создании
    Может принимать поезда (по одному за раз)
    Может возвращать список всех поездов на станции, находящиеся в текущий момент
    Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
    Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).


Класс Route (Маршрут):

    Имеет начальную и конечную станцию, а также список промежуточных станций. Начальная и конечная станции указываютсся при создании маршрута, а промежуточные могут добавляться между ними.
    Может добавлять промежуточную станцию в список
    Может удалять промежуточную станцию из списка
    Может выводить список всех станций по-порядку от начальной до конечной


Класс Train (Поезд):

    Имеет номер (произвольная строка) и тип (грузовой, пассажирский) и количество вагонов, эти данные указываются при создании экземпляра класса
    Может набирать скорость
    Может возвращать текущую скорость
    Может тормозить (сбрасывать скорость до нуля)
    Может возвращать количество вагонов
    Может прицеплять/отцеплять вагоны (по одному вагону за операцию, метод просто увеличивает или уменьшает количество вагонов). Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
    Может принимать маршрут следования (объект класса Route).
    При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
    Может перемещаться между станциями, указанными в маршруте. Перемещение возможно вперед и назад, но только на 1 станцию за раз.
    Возвращать предыдущую станцию, текущую, следующую, на основе маршрута
=end

class Station #
  @@station_count = 0
  @@stations =[] #все станции

  attr_accessor :station_name
  attr_accessor :arrived_trains

  def initialize (station_name) #создание станции
    @station_name = station_name
    @@stations.push(@station_name) #создаем конкретную станцию
    @arrived_trains = []
    @@station_count +=1
    puts "log: создана станция #{@station_name}"
    puts @@stations
  end

  def self.number_of_station #подсчет количества станций
    @@station_count #сколько мы создали станций
  end

  def display_all #посмотреть все станции со всеми поездами
    puts "список всех станций"
    @i=0
    @@stations.each do |value|
      puts "стация №#{@i} #{value}"
      @i +=1
    end
  end

  def arrival (train) #прибытие поезда на станцию

    @arrived = train
    @train_num = @arrived.train_name
    @train_type = @arrived.train_type
    @arrived_trains.push(@arrived)


    puts "log: на станцию #{@station_name} прибыл поезд #{@arrived_trains.last.train_name}"
    #проверяем что поезда приехали на станцию

  end


  def display #показать все поезда на станции
      if @arrived_trains.nil?
        puts "На станции нет поездов"
      else
      puts "log: На стации  #{@station_name} стоят следующие поезда:"
      @arrived_trains.each do  |key,value|
        puts "поезд № #{key}, тип поезда #{value}"
        end
      end
  end

  def count_train #посчиать количество поездов по типам
    @count_train = [] # массив с типами поездов
    @total_train = Hash.new(0)  # итоговый хеш с результатами подсчетов
    i=0

    @arrived_trains.each do |key| #каждый тип поезда помещаем в массив для подсчета
      @count_train[i] =key.train_type
      i +=1
    end
    puts "список поездов на станции #{@station_name} по типам"
    @count_train.each do |value|
      @total_train[value] +=1
    end
    @total_train.each do |key,value|
      puts "тип: #{key}, количество поездов: #{value}"
    end

  end
  def departure (train_num)
    @arrived_trains.delete(train_num)
    puts "поезд №#{train_num} покинул станцию #{@station_name}"

  end

end

class Route
attr_accessor :route_name # имя маршрута
attr_accessor :begin_station
attr_accessor :end_station
@@routes_count = 0
attr_accessor :route_name
attr_reader :station_list

  def initialize (name,station1,station2)
    @route_name = name
    @station1 = station1
    @station2 = station2
    @begin_station = @station1.station_name
    @end_station = @station2.station_name
    @station_list = [@begin_station,@end_station]
    @@routes_count +=1
    puts "Создан маршрут #{@route_name}"
    puts "начальная станция: #{@begin_station}, конечная станция: #{@end_station} "
  end

  def add_station(station) #Добавляем промежуточную станцию, при этом последняя всегда сдвигается
    @station_new = station
    @last_station = @station_list.last
    @station_list[@station_list.length-1] = @station_new.station_name
    @station_list.insert(@station_list.length, @last_station)
  end
  def delete (i)
    if i <= @station_list.length && i>0
      @station_list.delete_at(i-1)
      puts "станция #{i} удалена"
    else
      puts "такой станции нет"
    end
  end
  def display #отобразить маршрут станций
    puts "Маршрут состоит из следующих станций"
    @i = 0
    @station_list.each do |value|
      puts "#{@i+1}. #{@station_list[@i]}"
      @i +=1
    end

  end
end

class Train  # класс создаем поезд
  attr_accessor :speed
  attr_accessor :wagoon_count
  attr_accessor :train_name
  attr_accessor :train_type
  attr_reader :current_station
  attr_reader :current_station_name

  def initialize (num,wagoon)
    @train_name=num
    @wagoon_count=wagoon.to_i
    @speed = 0
    puts "Пжл-та выберите тип поезда "

    loop do
      puts "1: грузовой, 2: пассажирский"
      @train_type = gets.chomp.to_i
      break if @train_type == 1 || @train_type ==2
    end
  end

  def gas_on (delta) #повышение скорости поезда на дельту
    @speed +=delta
  end

  def change_wagoon


        if @speed != 0
          puts "поезд находится в движении, выполните команду stop"
        else

          loop do
            puts "чтобы отцепить вагон нажмите 1, чтобы прицепить 2"
            @operation = gets.chomp.to_i
            if @operation ==1
              @wagoon_count = @wagoon_count -1
            elsif @operation ==2
              @wagon_count = @wagoon_count + 1
            else
              puts "выбрана некорректная операция. Выберите снова"
            end
            break if @operation ==1 || @operation ==2
          end
        end


  end

  def stop #полный стоп
    @speed = 0
  end

  def set_route (route) #назначить маршрут
    @route = route
    puts "назначен маршрут #{@route.route_name}"
    puts @route.begin_station
    @current_station = 0
    @current_station_name =@route.station_list[0]

  end

  def go_on_route
    puts "Поезд отправляется со станции #{@route.station_list[@current_station]}"

    if @current_station <@route.station_list.count-1
      @current_station +=1
      @current_station_name = @route.station_list[@current_station]
      puts "Вы прибыли на станцию#{@current_station_name}"
    else
      puts "Вы достигли конечной станции. Поезд дальше не идет"
    end
  end

  def go_back_route
    puts "Поезд отправляется со станции #{@route.station_list[@current_station]}"

    if @current_station <@route.station_list.count &&@current_station>0
      @current_station -=1
      @current_station_name = @route.station_list[@current_station]
      puts "Вы прибыли на станцию #{@current_station_name}"
    else
      puts "Вы достигли конечной станции. Поезд дальше не идет"
    end
  end

  def display_st
    puts "текущая станция #{@route.station_list[@current_station]}"
    puts "предыдущая станция #{@route.station_list[@current_station-1]}"
    puts "следующая станция #{@route.station_list[@current_station]+1}"

  end
end
