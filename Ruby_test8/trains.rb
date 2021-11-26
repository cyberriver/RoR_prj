# trains managemetn class
# frozen_string_literal: true

$LOAD_PATH << '.'
require 'producer'
require 'instance_counter'
# super класс создаем поезд
class Train
  include Producer
  include InstanceCounter
  attr_accessor :speed, :train_num, :train_type, :train_type_name
  attr_reader :current_station, :current_station_name, :wagoons

  @@all_trains = []
  PATTERN = /^([а-я]|\d)([а-я]|\d)([а-я]|\d)(-|)([а-я]|\d)([а-я]|\d)/i.freeze

  def self.find(num)
    @@all_trains = ObjectSpace.each_object(self).to_a
    @@all_trains.each do |value|
      return value if value.train_num == num
    end
  end

  def initialize(num)
    @train_num = num.to_s
    @wagoon_count = 0
    @speed = 0
    @train_type = 0
    @train_type_name = 'metaTrain'
    @wagoons = []
    register_instances
    validate!
  end

  def block_call(block)
    @wagoons.each do |wagoon|
      block.call(wagoon)
    end
  end

  # повышение скорости поезда на дельту
  def gas_on(delta)
    @speed += delta
  end

  # изменить состав поезда , 1 - удалить, 2 добавить
  def add_wagoon(wagoon)
    if wagoon.wagoon_type == @train_type
      @wagoons.push(wagoon)
    else
      puts 'К пассажирскому поезду можно прицепить только пассажирские, к грузовому - грузовые'
      puts 'пжл-та укажите другой вагон'
    end
    display_w
  end

  def display_w
    i = 0
    @wagoons.each do |value|
      puts "#{i}. #{value}"
      i += 1
    end
  end

  # изменить состав поезда , 1 - удалить, 2 добавить
  def delete_wagoon(wagoon)
    @wagoons.delete(wagoon)
  end

  # полный стоп
  def stop
    @speed = 0
  end

  # назначить маршрут
  def config_route(_route)
    puts "назначен маршрут #{@route.route_name}"
    puts @route.station1
    @current_station = 0
    @current_station_name = @route.station_list[0]
  end

  def go_on_route
    puts "Поезд отправляется со станции #{@route.station_list[@current_station]}"
    if @current_station < @route.station_list.count - 1
      @departure_station = @route.station_list[@current_station]
      @departure_station.departure(self)
      @current_station += 1
      @arrival_station = @route.station_list[@current_station]
      @arrival_station.arrival(self)
      puts "Вы прибыли на станцию#{@current_station_name.station_name}"
    else
      puts 'Вы достигли конечной станции. Поезд дальше не идет'
    end
  end

  def go_back_route
    puts "Поезд отправляется со станции #{@route.station_list[@current_station]}"
    if @current_station < @route.station_list.count && @current_station.positive?
      @departure_station = @route.station_list[@current_station]
      @departure_station.departure(self)
      @current_station -= 1
      @arrival_station = @route.station_list[@current_station]
      @arrival_station.arrival(self)
      puts "Вы прибыли на станцию#{@current_station_name.station_name}"
    else
      puts 'Вы достигли конечной станции. Поезд дальше не идет'
    end
  end

  def display_st
    puts "текущая станция #{@route.station_list[@current_station]}"
    puts "предыдущая станция #{@route.station_list[@current_station - 1]}"
    puts "следующая станция #{@route.station_list[@current_station] + 1}"
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  private # метод для валидации введенного значения

  def validate!
    raise 'Номер не соответствует шаблону' if @train_num !~ PATTERN
    raise 'Номер не может быть пустым' if @train_num == ''
    raise 'Номер не может быть меньше 3х символов' if @train_num.length < 3
  end
end
