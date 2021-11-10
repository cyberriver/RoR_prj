class Train  # super класс создаем поезд
  attr_accessor :speed
  attr_accessor :train_name
  attr_accessor :train_type
  attr_accessor :train_type_name
  attr_reader :current_station
  attr_reader :current_station_name

  def initialize (num)
    @train_name=num
    @wagoon_count=0
    @speed = 0
    @train_type = 0
	@train_type_name ="metaTrain"
	@wagoons = []
  end

  def gas_on (delta) #повышение скорости поезда на дельту
    @speed +=delta
  end


	def add_wagoon (wagoon) #изменить состав поезда , 1 - удалить, 2 добавить
			if wagoon.wagoon_type == @train_type
				 @wagoons.push(wagoon)
			else
				puts "К пассажирскому поезду можно прицепить только пассажирские, к грузовому - грузовые"
				puts "пжл-та укажите другой вагон"
			end
			self.display_w
	end

	def display_w
			i = 0
			@wagoons.each do |value|
				puts "#{i}. #{value}"
				i+=1
			end

	end

  def delete_wagoon (wagoon) #изменить состав поезда , 1 - удалить, 2 добавить
			@wagoons.delete(wagoon)
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

      @departure_station = @route.station_list[@current_station]
      @departure_station.departure(self)
      @current_station +=1
      @arrival_station = @route.station_list[@current_station]
      @arrival_station.arrival(self)
      puts "Вы прибыли на станцию#{@current_station_name.station_name}"
    else
      puts "Вы достигли конечной станции. Поезд дальше не идет"
    end
  end

  def go_back_route
    puts "Поезд отправляется со станции #{@route.station_list[@current_station]}"

    if @current_station <@route.station_list.count &&@current_station>0

      @departure_station = @route.station_list[@current_station]
      @departure_station.departure(self)
      @current_station -=1
      @arrival_station = @route.station_list[@current_station]
      @arrival_station.arrival(self)
      puts "Вы прибыли на станцию#{@current_station_name.station_name}"
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
