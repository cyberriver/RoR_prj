# frozen_string_literal: true
module RoutesOperations
  ROUTES_MENU =
    '
  Выберите раздел
  1 - создать маршрут
  2 - добавить\удалить станцию к маршруту
  3 - отобразить доступные машруты
  4 - посмотреть список станций в маршруте
  0 - вернуться в предыдущее меню'

  def routes_menu
    puts ROUTES_MENU
    loop do
      case gets.chomp.to_i
      when 1 then create_route
      when 2 then change_route
      when 3 then display_route
      when 4 then display_route_stations
      when 0 then break
      else
        puts 'вы ввели некорректное значение'
      end
    end
  end

  def display_route_stations
    display_route?
    print 'пжл-та выберите маршрут'
    i = gets.chomp.to_i
    k = 1
    @routes[i].station_list.each do |value|
      puts "#{k}. #{value.station_name}"
      k += 1
    end
    puts ROUTES_MENU
  end

  def create_route
    puts 'Чтобы создать маршрут выберите номер начальной и конечной станции'
    display_station?
    print 'выберите название маршрута: '
    n = gets.chomp.to_s
    print 'выберите номер начальной станции: '
    b = gets.chomp.to_i
    print 'выберите номер конечной станции: '
    e = gets.chomp.to_i
    @routes.push(Route.new(n, @stations[b], @stations[e]))
    puts "Создан маршрут #{@route_name}"
    puts "начальная станция: #{@stations[b].station_name}, конечная станция: #{@stations[e].station_name} "
    puts ROUTES_MENU
  rescue RuntimeError => e
    puts "log:#{e.message}"
    retry
  end

  def display_route
    puts 'список маршрутов'
    i = 0
    @routes.each do |value|
      puts "#{i}.#{value.route_name}"
      i += 1
    end
    puts ROUTES_MENU
  end

  def change_route
    puts 'Выберите номер маршрута, который хотите поменять'
    display_route?
    print 'Выберите номер: '
    i = gets.chomp.to_i
    puts 'выберите действие 1 - добавить станцию, 2 - удалить '
    action = gets.chomp.to_i
    case action
    when 1
      puts 'выберите номер станции, которую добавить'
      display_station?
      k = gets.chomp.to_i
      @routes[i].add_station(@stations[k])
      puts ROUTES_MENU
    when 2
      puts 'выберите номер станции которую удалить из маршрута'
      @routes[i].display
      k = gets.chomp.to_i
      @routes[i].delete(k)
      @routes[i].display
      puts ROUTES_MENU
    else
      puts 'вы выбрали что-то непонятное'
    end
  end

  def display_route?
    puts 'список маршрутов'
    i = 0
    @routes.each do |value|
      puts "#{i}.#{value.route_name}"
      i += 1
    end
  end
end
