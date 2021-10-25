
#Заданы 3 числа (число, месяц, год)
#найти порядковый номер даты, начинаем с начала года
#учесть что год может быть вискосный
puts " пжл-та введите год"
year = gets.chomp.to_i
puts " пжл-та введите месяц"
month = gets.chomp.to_i
puts " пжл-та введите день"
day = gets.chomp.to_i
#отформатированные дни и месяцы
f_day =""
f_month =""

if day.to_s.length ==1
  f_day ="0#{day}"
else
  f_day =day
end

if month.to_s.length ==1
  f_month ="0#{month}"
else
  f_month =month
end

#сохраняем отформатированную дату
date = f_day.to_s+"."+f_month.to_s+"."+year.to_s
puts"log: Вы ввели #{date} "
start_year = 2020 #точка отсчета, високосный год

#делаем календарь с днями в месяце
calendar = {
  "01"=>31,
  "02"=>28,
  "03"=>31,
  "04"=>30,
  "05"=>31,
  "06"=>30,
  "07"=>31,
  "08"=>31,
  "09"=>30,
  "10"=>31,
  "11"=>30,
  "12"=>31
}

puts "log: calendar = #{calendar}"

cal_count= Hash.new()
#делаем хе календаря с порядковым номером

k_day = ""
i = 1 #счетчик дней

#раскрываем календарь днями

#проверка что год високосный
  if (year - start_year)%4 ==0
    puts "год вискосный, правим календарь"
    calendar["08"]=29
  else
    puts "год не вискосный, берем обычный календарь"
  end

calendar.each do |month, days|
  days.to_i.times do |day|

    #преврашаем день в 2х значную строку, чтобы дату корректно сравнивать
    if day.to_s.length ==1
      k_day ="0#{day}"
    else
      k_day = day.to_s
    end
    # напомняем хеш днем и его номером
    cal_count["#{k_day}.#{month}.#{year}"] = i
    puts "log:  #{k_day}.#{month}.#{year}"
    i +=1 #увеличиваем счетчик

  end
end
# проверяем что получилось
puts "log: отформатированный календарь= #{cal_count}"

# РЕШЕНИЕ ищем номер дням

puts "Номер дня, который вы ввели #{cal_count[date]}"
