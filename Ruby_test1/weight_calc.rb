print "Hi! Pls enter your name: "
name = gets
puts "You have entered: " + name
param = 100
print "Pls enter your height: "
height = gets.to_f
puts "log: You have entered: " + height.to_s
ideal_weight = (height - param)*1.15
puts "log:ideal_weigh calc = "+ ideal_weight.to_s
check = ideal_weight < 0.0
puts "log: check is " + check.to_s

unless check
  print "Dear " + name + " your ideal weight is "
  + ideal_weight.to_s

else
  print "Dear " + name + "you have alreddy ideal weight"

end
