# frozen_string_literal: true
# This class for routes management

$LOAD_PATH << '.'
require 'instance_counter'
class Route
  attr_accessor :route_name, :station1, :station2
  attr_reader :station_list, :deleted

  include InstanceCounter

  def initialize(name, station1, station2)
    @route_name = name
    @station1 = station1
    @station2 = station2
    @station_list = [@station1, @station2]
    register_instances
    validate! :station1, :presense
    validate! :station2, :presense
  end

  # Добавляем промежуточную станцию, при этом последняя всегда сдвигается
  def add_station(station)
    if @station_list.include?(station)
      puts 'такая станция уже есть'
    else
      @station_list.insert(-2, station)
      puts 'станция добавлена'
    end
  end

  def delete(par)
    if par <= @station_list.length && par.positive?
      deleted = @station_list[par - 1]
      @station_list.delete_at(par - 1)
      puts "станция #{par} #{deleted.station_name} удалена"
    else
      puts 'такой станции нет'
    end
  end

  # отобразить маршрут станций
  def display
    puts 'Маршрут состоит из следующих станций'
    i = 0
    @station_list.each do |_value|
      puts "#{i + 1}. #{@station_list[i].station_name}"
      i += 1
    end
  end
end
