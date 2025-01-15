def evaluate(string)
  if string[1] == "||"
    string[0] + string[2]
  else
    eval(string.join)
  end
end

# file = File.read("sample_7.txt").split("\n")
file = File.read("input_day_7.txt").split("\n")

valid_test_values = file.map do |equation|
  test_value = equation.split(":").first.to_i
  numbers = equation.split(":").last.strip

  p_operators = ["+", "*", "||"].repeated_permutation(numbers.count(" ")).to_a

  operation_results = false
  p_operators.map do |operators|
    dup_numbers = numbers.dup
    numbers.count(" ").times do |i|
      blank_space = dup_numbers.index(" ")
      dup_numbers[blank_space] = operators.shift
    end
    dup_numbers.gsub!("+", " + ")
    dup_numbers.gsub!("*", " * ")
    dup_numbers.gsub!("||", " || ")
    conta = dup_numbers.split
    while conta.length > 2
      res = evaluate(conta[0..2])
      conta[0..2] = res.to_s
    end
    if conta[0].to_i == test_value
      operation_results = true
      break
    end
  end
  test_value if operation_results
end.compact

puts valid_test_values.sum
