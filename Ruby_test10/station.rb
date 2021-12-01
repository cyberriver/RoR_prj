# station management class
# frozen_string_literal: true

$LOAD_PATH << '.'
require 'instance_counter'
class Station
  attr_accessor :station_name, :arrived_trains

  include InstanceCounter
  @@stations = 0
  @@all_stations = []

  def self.all
    @@all_stations = ObjectSpace.each_object(self).to_a
    puts "Всего создано станций: #{@@stations}"
    i = 1
    @@all_stations.each do |value|
      puts "#{i}.#{value.station_name}"
      i += 1
    end
  end

  # создание станции
  def initialize(station_name)
    @station_name = station_name
    @arrived_trains = []
    @@stations += 1
    register_instances
    validate!
  end

  # прибытие поезда на станцию
  def arrival(train)
    @arrived_trains.push(train)
  end

  # посчиать количество поездов по типам
  def count_train
    count_train = [] # массив с типами поездов
    total_train = Hash.new(0) # итоговый хеш с результатами подсчетов
    i = 0
    @arrived_trains.each do |key| # каждый тип поезда помещаем в массив для подсчета
      count_train[i] = key.train_type
      i += 1
    end
    if count_train.size.zero?
      puts 'на станции нет поездов'
    else
      puts "список поездов на станции #{@station_name} по типам"
      count_train.each do |value|
        total_train[value] += 1
      end
    end
    total_train.each do |key, value|
      puts "тип: #{key}, количество поездов: #{value}"
    end
  end

  def departure(train)
    @arrived_trains.delete(train)
    puts "поезд №#{train.train_name} покинул станцию #{@station_name}"
  end

  def block_call(block)
    @arrived_trains.each do |train|
      block.call(train)
    end
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  private # метод для валидации введенного значения

  def validate!
    raise 'Название станции не может быть пустым' if @station_name == ''
    raise 'Название станции не может быть меньше 5 символов' if @station_name.length < 5
  end
end
