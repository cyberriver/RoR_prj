print "Добрый день! Пжл-та введите переменну a: "
a = gets.to_i
puts "Log: Вы ввели: " + a.to_s

print "Пжл-та введите переменну b: "
b = gets.to_i
puts "Log: Вы ввели: " + b.to_s

print "Пжл-та введите переменну c: "
c = gets.to_i
puts "Log: Вы ввели: " + c.to_s

#Вычисление Дискриминанта
d=b**2-4*a*c
puts "Дискриминант = " + d.to_s

#Вычисление корней уравнения
if d > 0

x1=(-1*b-Math.sqrt(d))/(2*a)
puts "Корень уравнения х1 = " + x1.to_s
x2=(-1*b+Math.sqrt(d))/(2*a)
puts "Корень уравнения х1 = " + x2.to_s
elsif d==0

  x=(-1*b)/(2*a)
  puts "Корень уравнения х = " + x.to_s

else
  puts "Дискриминант отрицательный, корней в уравнении нет"
end
