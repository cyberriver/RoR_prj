require_relative  'main.rb'

menu = Main.new()

	loop do

		action = gets.chomp.to_i

		case action
		when 1 then #операции со станциями
			puts Main::STATION_MENU
			a2 = gets.chomp.to_i
			loop do
				case a2
				when 1 then menu.create_station
				when 2 then menu.display_station
				when 3 then menu.count_trains
				when 0 then break
				else
					puts "вы ввели некорректное значение"
				end
				a2 = gets.chomp.to_i
			end
		when 2 then # операции  поездами
			puts Main::TRAIN_MENU
			a2 = gets.chomp.to_i
			loop do
				case a2
				when 1 then menu.create_station
				when 2 then menu.display_station
				when 3 then menu.count_trains
				when 0 then break
				else
					puts "вы ввели некорректное значение"
				end
				a2 = gets.chomp.to_i
			end

		when 3 then # операции с вагонами
			puts Main::WAGOON_MENU

		when 4 then #операции с маршрутами
			puts Main::ROUTES_MENU
			a2 = gets.chomp.to_i
			loop do
				case a2
				when 1 then menu.create_route
				when 2 then menu.display_station
				when 3 then menu.count_trains
				when 0 then break
				else
					puts "вы ввели некорректное значение"
				end
				a2 = gets.chomp.to_i
			end

		when 0 then break
		else
			puts "вы ввели некорректное значение"
		end
		puts "                    "
		puts Main::INSTRUCTIONS
	end
