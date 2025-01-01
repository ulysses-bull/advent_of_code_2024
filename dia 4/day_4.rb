def count_horizontal(matrix)
  count = 0
  matrix.each_with_index do |line, i|
    line.each_with_index do |char, j|
      word = matrix[i][j..j+3].join
      if word == "XMAS" || word == "SAMX"
        count += 1
      end
    end
  end
  count
end

def count_vertical(matrix)
  count = 0
  matrix.each_with_index do |line, i|
    line.each_with_index do |char, j|
      word = matrix[i..i+3].map {|l| l[j] }.join
      if word == "XMAS" || word == "SAMX"
        count += 1
      end
    end
  end
  count
end

def count_diagonal_left(matrix)
  count = 0
  0.upto(matrix.length-4) do |i|
    line = matrix[i]
    0.upto(line.length-4) do |j|
      word = [matrix[i][j], matrix[i+1][j+1], matrix[i+2][j+2], matrix[i+3][j+3]].compact.join
      if word == "XMAS" || word == "SAMX"
        count += 1
      end
    end
  end
  count
end

def count_diagonal_right(matrix)
  count = 0
  0.upto(matrix.length-4) do |i|
    line = matrix[i]
    (line.length-1).downto(3) do |j|
      word = [matrix[i][j], matrix[i+1][j-1], matrix[i+2][j-2], matrix[i+3][j-3]].compact.join
      if word == "XMAS" || word == "SAMX"
        count += 1
      end
    end
  end
  count
end

file = File.read("input_day_4.txt")
matrix = file.split("\n").map(&:chars)

puts "Horizontal: #{count_horizontal(matrix)}"
puts "Vertical: #{count_vertical(matrix)}"
puts "Diagonal esquerda: #{count_diagonal_left(matrix)}"
puts "Diagonal direita: #{count_diagonal_right(matrix)}"

puts "Total: #{count_horizontal(matrix) + count_vertical(matrix) + count_diagonal_left(matrix) + count_diagonal_right(matrix)}"

# word = ""
# matrix.each_with_index do |line, i|
#   line.each_with_index do |, j|
#   end
# end
