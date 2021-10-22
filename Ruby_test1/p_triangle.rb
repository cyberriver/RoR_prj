print "Добрый день! Пжл-та введите сторону 1 треугольника: "
side1 = gets.to_i
puts "Log: Вы ввели: " + side1.to_s

print "Добрый день! Пжл-та введите сторону 2 треугольника: "
side2 = gets.to_i
puts "Log: Вы ввели: " + side2.to_s

print "Добрый день! Пжл-та введите сторону 2 треугольника: "
side3 = gets.to_i
puts "Log: Вы ввели: " + side3.to_s

if side1==side2&&side1==side3
  puts "Треугольник равнобедренный"

  elsif  side1 ==side2 || side1==side3
  puts "Треугольник прямоугольный"
else
  puts "Треугольник не прямоугольный и не равнобедренный"
end
