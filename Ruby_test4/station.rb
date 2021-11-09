=begin
Разбить программу на отдельные классы (каждый класс в отдельном файле)
Разделить поезда на два типа PassengerTrain и CargoTrain,
сделать родителя для классов, который будет содержать общие
методы и свойства Определить, какие методы могут быть помещены
в private/protected и вынести их в такую секцию. В комментарии
к методу обосновать, почему он был вынесен в private/protected
Вагоны теперь делятся на грузовые и пассажирские (отдельные
классы). К пассажирскому поезду можно прицепить только
пассажирские, к грузовому - грузовые. При добавлении вагона
к поезду, объект вагона должен передаваться как аргумент
метода и сохраняться во внутреннем массиве поезда, в отличие
от предыдущего задания, где мы считали только кол-во вагонов.
Параметр конструктора "кол-во вагонов" при этом можно удалить.


Добавить текстовый интерфейс:

Создать программу в файле main.rb, которая будет
позволять пользователю через текстовый интерфейс делать
следующее:
 - Создавать станции
 - Создавать поезда
 - Создавать маршруты и управлять станциями в нем
 (добавлять, удалять)
 - Назначать маршрут поезду
 - Добавлять вагоны к поезду
 - Отцеплять вагоны от поезда
 - Перемещать поезд по маршруту вперед и назад
 - Просматривать список станций и список поездов на станции

В качестве ответа приложить ссылку на репозиторий с решением
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
    puts "log: итого станций"
    puts "log: #{@@stations}"
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
      @arrived_trains.each do  |key|
        puts "поезд № #{key.train_name}, тип поезда #{key.train_type}"
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
		if @count_train.size()==0
			puts "на станции нет поездов"
		else
			puts "список поездов на станции #{@station_name} по типам"
			@count_train.each do |value|
				@total_train[value] +=1
			end
		end

    @total_train.each do |key,value|
      puts "тип: #{key}, количество поездов: #{value}"
    end

  end
  def departure (train)
    @arrived_trains.delete(train)
    puts "поезд №#{train.train_name} покинул станцию #{@station_name}"

  end

end
