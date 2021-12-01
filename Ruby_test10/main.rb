# main interface class
# frozen_string_literal: true

$LOAD_PATH << '.'
require 'station_operations'
require 'trains_operations'
require 'wagoon_operations'
require 'routes_operations'

class Main
  include StationOperations
  include TrainOperations
  include WagoonOperations
  include RoutesOperations
  require_relative  'station'
  require_relative  'trains'
  require_relative  'routes'
  require_relative  'cargo_train'
  require_relative  'passenger_train'
  require_relative  'wagoon'
  attr_accessor :stations, :trains, :routes, :wagoons

  INSTRUCTIONS =
    '
  Выберите раздел
  1 - операции со станциями
  2 - операции с поездами
  3 - операции с вагонами
  4 - операции с маршрутами
  0 - выйти'

  def initialize
    @stations = []
    @trains = []
    @routes = []
    @wagoons = []
    @producer = []
    puts INSTRUCTIONS
  end

  def start
    loop do
      case gets.chomp.to_i
      when 1 then station_menu
      when 2 then train_menu
      when 3 then wagoon_menu
      when 4 then routes_menu
      when 0 then break
      else
        puts 'вы ввели некорректное значение'
      end
      puts INSTRUCTIONS
    end
  end
end
