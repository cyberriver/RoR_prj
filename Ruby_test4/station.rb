class Station #
  attr_accessor :station_name
  attr_accessor :arrived_trains
  def initialize (station_name) #создание станции
    @station_name = station_name
    @arrived_trains = []
  end
  def arrival (train) #прибытие поезда на станцию
    @arrived_trains.push(train)
    puts "log: на станцию #{@station_name} прибыл поезд #{@arrived_trains.last.train_name}"
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
    count_train = [] # массив с типами поездов
    total_train = Hash.new(0)  # итоговый хеш с результатами подсчетов
    i=0
    @arrived_trains.each do |key| #каждый тип поезда помещаем в массив для подсчета
    	count_train[i] =key.train_type
    	i +=1
    end
		if count_train.size()==0
			puts "на станции нет поездов"
		else
			puts "список поездов на станции #{@station_name} по типам"
			count_train.each do |value|
				total_train[value] +=1
			end
		end
    total_train.each do |key,value|
      puts "тип: #{key}, количество поездов: #{value}"
    end
  end
  def departure (train)
    @arrived_trains.delete(train)
    puts "поезд №#{train.train_name} покинул станцию #{@station_name}"
  end
end
