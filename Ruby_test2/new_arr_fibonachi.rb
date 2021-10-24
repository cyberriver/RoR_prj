arr = []
arr[0]=1

i=1
limit = 100
stop = false

#цикл заполнения массива
until stop   do
  if (arr[i-1] + arr[i-2])<100
    arr[i] = arr[i-1] + arr[i-2]
    puts "log: #{arr[i]}"
    i +=1
  else
    stop = true
  end

end
