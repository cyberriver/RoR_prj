$LOAD_PATH << '.'
require 'instance_counter.rb'
class Route
  attr_accessor :route_name, :station1, :station2, :station_list
  attr_reader :station_list, :deleted
  include Instance_counter

  def initialize (name,station1,station2)
    @route_name = name
    @station1 = station1
    @station2 = station2
    @station_list = [@station1,@station2]
    register_instances
    validate!
  end

  def add_station(station) #Добавляем промежуточную станцию, при этом последняя всегда сдвигается
    if @station_list.include?(station)
      puts "такая станция уже есть"
    else
      @station_list.insert(-2, station)
      puts "станция добавлена"
    end
  end

  def delete (i)
    deleted = 0
    if i <= @station_list.length && i>0
      deleted = @station_list[i-1]
      @station_list.delete_at(i-1)
      puts "станция #{i} #{deleted.station_name} удалена"
    else
      puts "такой станции нет"
    end
  end

  def display #отобразить маршрут станций
    puts "Маршрут состоит из следующих станций"
    i = 0
    @station_list.each do |value|
      puts "#{i+1}. #{@station_list[i].station_name}"
      i +=1
    end
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  private # метод для валидации введенного значения
  def validate!
    [@station1, @station2].each {|station| raise "Название станции не может быть пустым" if station == ""}
  end
end
