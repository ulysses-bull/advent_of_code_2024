file = File.read("input_day_3.txt")

mul_functions = file.scan(/mul\(\d+,\d+\)/)
mul_numbers = mul_functions.map do |function|
  function.scan(/\d+/).map(&:to_i)
end

puts mul_numbers.map { |numbers| numbers[0] * numbers[1] }.sum
