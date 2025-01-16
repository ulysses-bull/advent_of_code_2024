def antenna_frequencies
  @local_map.flatten.select { |c| c != "." }.uniq
end

def get_positions_for frequency
  positions = []
  @local_map.each_with_index do |line, i|
    line.each_with_index do |char, j|
      if char == frequency
        positions << [i, j]
      end
    end
  end
  positions
end

def calculate_antinode(a, b)
  # (A + (A - B))
  difference = [a[0] - b[0], a[1] - b[1]]
  [a[0] + difference[0], a[1] + difference[1]]
end

def valid_antinodes(antinodes_list)
  antinodes_list.select { |a| a[0] >= 0 && a[0] <= MAX_Y && a[1] >= 0 && a[1] <= MAX_X }.uniq.count
end

# file = File.read("sample_8.txt")
file = File.read("input_day_8.txt")
@local_map = file.split("\n").map(&:chars)
MAX_Y = @local_map.length - 1
MAX_X = @local_map[0].length - 1

frequencies = antenna_frequencies
antinodes = []

frequencies.each do |frequency|
  frequency_positions = get_positions_for(frequency)
  frequency_positions.each_with_index do |position, index|
    next_positions = frequency_positions[index + 1..]
    next_positions.each do |next_p|
      antinodes << calculate_antinode(position, next_p)
      antinodes << calculate_antinode(next_p, position)
    end
  end
end

puts valid_antinodes(antinodes)
