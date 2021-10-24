arr = []
arr[0]=10
i=1
limit = 100

while arr[-1] <limit do
  arr[i] = arr[i-1] + 5
  puts "log: #{arr[i]}"
  i +=1
end
