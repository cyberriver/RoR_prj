class Wagoon
  attr_accessor :wagoon_type,:wagoon_name

  def initialize()
    puts "выберите тип вагона"
    puts "1 - вагон грузовой"
    puts "2 - вагон пассажирский"
    @wagoon_type = gets.chomp.to_i
    if @wagoon_type ==2
      @wagoon_name = "вагон пассажирский"
    elsif @wagoon_type ==1
      @wagoon_name = "вагон грузовой"
    else
      return
    end
    # проверка, что ввели корректное значение
    if [1,2].include?(@wagoon_type)
      return
    else
      wagoon_type?
    end
  end

  private # метод для валидации введенного значения
  def wagoon_type?
    puts "Вы ввели не существующий тип вагона"
    puts "пжл-та выберите снова 1 или 2"
    loop do
      @wagoon_type = gets.chomp.to_i
      break if [1,2].include?(@wagoon_type)
      puts "Вы ввели не существующий тип вагона"
      puts "пжл-та выберите снова 1 или 2"
    end
  end
end
