#корзина покупок, покупатель вводит покупки
#название товара, цена, количество
#пока не введено слово "стоп"
#нужно сдеать хеш содержащий имя товара,
#и хеш содержащий цену за ед. товара и кол-вл
puts "=====Ваш список покупок========"
puts "== Введите товар, цену за единицу и количество. Нажмите Enter"
puts "== Чтобы завершить ввод покупок наберите стоп"
products = Hash.new() #хеш для продуктов
order_list = Hash.new() #вложенный хеш с ценами
product = ''  #данные по проукту
price = 0.0 #данные по проукту
qty = 0 #данные по проукту
stop = false
i = 1 #место в списке покупок
product_summary = 0 #итого по продукту
total = 0  #итого по списку

loop do
  #начинаем вводить покупки
  puts "введите товар"
  product = gets.chomp
  if product == "стоп"
  stop = true
  end
  break if stop == true

  puts "введите цену за единицу"
    price = gets.chomp

    if price =="стоп"
    stop = true
    end
    break if stop == true

  puts "введите количество товара"
    qty = gets.chomp

    if qty =="стоп"
    stop = true
    end
    break if stop == true

  #добавляем их в хеш, товары не дублируются, потому мы их через символы записываем
  order_list [price.to_f] = qty.to_i
  products[product.to_sym] = order_list

end
puts "хеш покупок"
puts "log: #{products}"
puts ""
#выводим на экран итоговую сумму за каждый товар
puts "============Ваш список покупок==================="
puts ""
puts "|№|Продукт |    итого   |"

products.each do |k, value|
  value.each do |pr, q|
    product_summary += pr.to_f*q.to_i
  end
  puts "#{i}. #{k} - #{product_summary}"
  i +=1
  total +=product_summary
end
puts "_________________________________________________"
puts "ИТОГО: #{total}"
