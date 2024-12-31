file = File.read("input_day_3.txt")

valid = true
mul_functions = file.scan(/don't\(\)|do\(\)|mul\(\d+,\d+\)/)
mul_numbers = mul_functions.map do |function|
  if function == "do()"
    valid = true
    nil
  elsif function == "don't()"
    valid = false
    nil
  else
    function.scan(/\d+/).map(&:to_i) if valid
  end
end.compact

puts mul_numbers.map { |numbers| numbers[0] * numbers[1] }.sum
