file = File.read("input_day_1.txt").split("\n")
numbers = file.map { _1.split("   ").map(&:to_i) }
left_numbers = numbers.map { |n| n[0] }.sort
right_numbers = numbers.map { |n| n[1] }.sort
total_distance = 0

0.upto(left_numbers.length - 1) do |i|
  total_distance += (left_numbers[i] - right_numbers[i]).abs
end
puts total_distance
