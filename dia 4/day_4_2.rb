file = File.read("input_day_4.txt")
matrix = file.split("\n").map(&:chars)

count = 0
0.upto(matrix.length-3) do |i|
  line = matrix[i]
  0.upto(line.length-3) do |j|
    left = matrix[i][j] + matrix[i+1][j+1] + matrix[i+2][j+2]
    right = matrix[i][j+2] + matrix[i+1][j+1] + matrix[i+2][j]
    if (left == "MAS" || left == "SAM") && (right == "MAS" || right == "SAM")
      count += 1
    end
  end
end

puts count
