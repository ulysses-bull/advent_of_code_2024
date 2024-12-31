file = File.read("input_day_1.txt").split("\n")
numbers = file.map { _1.split("   ").map(&:to_i) }
left_numbers = numbers.map { |n| n[0] }.sort
right_numbers = numbers.map { |n| n[1] }.sort

similarity = left_numbers.map do |l_number|
  apparitions = right_numbers.count(l_number)
  l_number * apparitions
end.sum

puts similarity
