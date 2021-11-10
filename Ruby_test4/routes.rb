class Route
attr_accessor :route_name # имя маршрута
attr_accessor :begin_station
attr_accessor :end_station

attr_accessor :route_name
attr_reader :station_list
attr_reader :deleted

  def initialize (name,station1,station2)
    @route_name = name
    @station1 = station1
    @station2 = station2
    @begin_station = @station1
    @end_station = @station2
    @station_list = [@begin_station,@end_station]

    puts "Создан маршрут #{@route_name}"
    puts "начальная станция: #{@begin_station.station_name}, конечная станция: #{@end_station.station_name} "
  end

  def add_station(station) #Добавляем промежуточную станцию, при этом последняя всегда сдвигается
    @station_new = station
    @last_station = @station_list.last
    @station_list[@station_list.length-1] = @station_new
    @station_list.insert(@station_list.length, @last_station)
		puts "станция добавлена"
		puts self.display
	end
  def delete (i)
    @deleted = 0
    if i <= @station_list.length && i>0
      @deleted = @station_list[i-1]
      @station_list.delete_at(i-1)
      puts "станция #{i} #{@deleted.station_name} удалена"
    else
      puts "такой станции нет"
    end
  end
  def display #отобразить маршрут станций
    puts "Маршрут состоит из следующих станций"
    @i = 0
    @station_list.each do |value|
      puts "#{@i+1}. #{@station_list[@i].station_name}"
      @i +=1
    end

  end
end
