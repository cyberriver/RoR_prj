class Wagoon
attr_accessor :wagoon_type

	def initialize()
		puts "выберите тип вагона"
		puts "2 - вагон грузовой"
		puts "1 - вагон пассажирский"

		@wagoon_type = gets.chomp.to_i
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
