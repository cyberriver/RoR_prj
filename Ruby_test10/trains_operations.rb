# frozen_string_literal: true
module TrainOperations
  TRAIN_MENU =
    '
  Выберите раздел
  1 - создать поезд
  2	- добавить вагон
  3 - удалить вагон
  4 - просмотреть все поезда
  5 - назначить маршрут поезду
  6 - поехать по маршруту
  7 - вернуться назад по маршруту
  8 - занять место / объем в вагоне
  0 - вернуться в предыдущее меню'

  def train_menu
    puts TRAIN_MENU

    loop do
      case gets.chomp.to_i
      when 1 then create_train
      when 2 then add_wagoon
      when 3 then delete_wagoon
      when 4 then display_train
      when 5 then config_route
      when 6 then move_on
      when 7 then move_back
      when 8 then fullfill_wagoon
      when 0 then break
      else
        puts 'вы ввели некорректное значение'
      end
    end
  end

  def create_train
    puts 'Выберите какой поезд создать'
    puts '1 - пассажирский'
    puts '2 - грузовой'
    print 'тип поезда: '
    k = gets.chomp.to_i
    case k
    when 1
      begin
        puts 'введите номер нового пассажирского поезда: '
        @trains.push(PassengerTrain.new(gets.chomp.to_s))
      rescue RuntimeError => e
        puts "log:#{e.message}"
        retry
      end
    when 2
      begin
        puts 'введите номер нового грузового поезда: '
        @trains.push(CargoTrain.new(gets.chomp.to_s))
      rescue RuntimeError => e
        puts "log:#{e.message}"
        retry
      end
    else
      puts 'вы выбрали что-то непонятное'
    end
    puts TRAIN_MENU
  end

  def add_wagoon
    display_train?
    print 'Выберите номер поезда для изменения состава '
    i = gets.chomp.to_i
    puts 'выберите вагон, который добавить'
    display_wagoon?
    k = gets.chomp.to_i
    @trains[i].add_wagoon(@wagoons[k])
    puts "вагон #{@wagoons[k].wagoon_name}добавлен "
    puts TRAIN_MENU
  end

  def delete_wagoon
    display_train?
    print 'Выберите номер поезда для изменения состава '
    i = gets.chomp.to_i
    puts 'выберите вагон, который отцепить'
    @trains[i].display_w
    k = gets.chomp.to_i
    @trains[i].delete(k)
    @trains[i].display
    puts TRAIN_MENU
  end

  def display_train
    puts 'список всех поездов'
    i = 0
    @trains.each do |value|
      puts "#{i}.#{value.train_num}"
      i += 1
    end
    puts TRAIN_MENU
  end

  def config_route
    display_train?
    print 'пжл-та выберите поезд'
    t = gets.chomp.to_i
    display_route?
    print 'пжл-та выберите маршрут для назначения поезду'
    i = gets.chomp.to_i
    @trains[t].config_route(@routes[i])
    puts "поезду #{@trains[t].train_num} назначен маршрут #{@routes[i]}"
    puts TRAIN_MENU
  end

  def display_train?
    puts 'список всех поездов'
    i = 0
    @trains.each do |value|
      puts "#{i}.#{value.train_num}"
      i += 1
    end
  end

  def move_on
    display_train?
    print 'пжл-та выберите поезд'
    t = gets.chomp.to_i
    @trains[t].go_on_route
    puts TRAIN_MENU
  end

  def move_back
    display_train?
    print 'пжл-та выберите поезд'
    t = gets.chomp.to_i
    @trains[t].go_back_route
    puts TRAIN_MENU
  end
end
