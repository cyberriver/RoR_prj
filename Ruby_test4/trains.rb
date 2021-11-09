class Train  # super класс создаем поезд
  attr_accessor :speed
  attr_accessor :wagoon_count
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

	
  def change_wagoon (operation, wagoon) #изменить состав поезда , 1 - удалить, 2 добавить
			@operation = operation
			@wagoon = wagoon

			if check_wagoon?
				loop do
					@wagoon =gets.chomp
					break if check_wagoon? == false
				end
			end
		  if @speed != 0
		          puts "поезд находится в движении, выполните команду stop"
		  else

		      if @operation ==1
									@wagoons.delete(wagoon)
		              @wagoon_count = @wagoon_count -1

		       elsif @operation ==2
									@wagoons.push(wagoon)
		              @wagoon_count = @wagoon_count + 1

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

	def check_wagoon?

		if @wagoon.wagoon_type == @train_type
			return false
		else
			puts "К пассажирскому поезду можно прицепить только пассажирские, к грузовому - грузовые"
			puts "пжл-та укажите другой вагон или наберите exit, чтобы выйти"

			return true

		end

	end

end
