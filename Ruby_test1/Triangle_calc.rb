print "Hi! Pls enter triangle height: "
triangle_height = gets.to_i

if triangle_height <= 0
  print "the height should be > 0. Pls re-enter once more"
  triangle_height = gets.to_i
else
  puts "Log: You have entered: " + triangle_height.to_s
end

print "Pls enter your triangle foundation: "
triangle_foundation = gets.to_i

if triangle_foundation <= 0
  print "the foudation should be > 0. Pls re-enter once more"
  triangle_foundation = gets.to_i
  else
  puts "Log: You have entered: " + triangle_foundation.to_s
  end


triangle_square = 0.5*triangle_height*triangle_foundation

print "Triangle square is " + triangle_square.to_s
