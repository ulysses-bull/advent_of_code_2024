file = File.read("sample_7.txt").split("\n")

valid_test_values = file.map do |equation|
  test_value = equation.split(":").first.to_i
  numbers = equation.split(":").last.strip

  p_operators = ["+", "*"].permutation(numbers.count(" ")).to_a

  operation_results = p_operators.map do |operators|
    binding.irb
    dup_numbers = numbers.dup
    numbers.count(" ").times do |i|
      blank_space = dup_numbers.index(" ")
      dup_numbers[blank_space] = operators.shift
    end
    dup_numbers.gsub!("+", " + ")
    dup_numbers.gsub!("*", " * ")
    conta = dup_numbers.split
    while conta.length > 2
      res = eval(conta[0..2].join)
      conta[0..2] = res
    end
    # result = eval(dup_numbers)
    # result == test_value
    conta[0] == test_value
  end
  # binding.irb
  test_value if operation_results.any?
end

binding.irb
