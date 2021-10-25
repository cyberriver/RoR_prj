
#Заполнить хеш глассными буквами,
#где значением является их порядковый номер
arr_abc = ('А'.."Я")
puts "log: #{arr_abc}"
arr_abc_1 = ["А","Е","О","И","Э","Я","Ы"]
puts "log: #{arr_abc_1}"

hash_abc = Hash.new()
puts "log: #{hash_abc}"
value = 1

#помещаем массив в хеш, где ключ это буква,
#а значение ее номер
arr_abc.each do |key|

  puts "log key: #{key} value: #{value}"
  hash_abc[key] = value
  puts "log #{hash_abc[:key]}"

  value +=1
end

#проверяем, что хеш работает
hash_abc.each do |key, value|
  puts "#{key} #{value}"

end

#удаляем из хеша все элементы, если они не гласные
hash_abc.each do |letter, |
  if arr_abc_1.include?(letter)
    puts "Гласная не удаляем"
  else
  hash_abc.delete (letter)
  end
end

#проверяем, что получилось с хешом 
hash_abc.each do |key, value|
  puts "#{key} #{value}"

end
