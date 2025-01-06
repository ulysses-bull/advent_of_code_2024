def current_position
  @local_map.map.with_index do |line, y|
    line.map.with_index do |char, x|
      spot = @local_map[y][x]
      if spot == "^" || spot == ">" || spot == "v" || spot == "<"
        [y, x]
      end
    end
  end.flatten.compact
end

def obstacle_positions
  obstacles = []
  @local_map.each_with_index do |line, y|
    line.each_with_index do |char, x|
      spot = @local_map[y][x]
      if spot == "#"
        obstacles << [y, x]
      end
    end
  end
  obstacles
end

def guard_direction(current_position)
  case @local_map.dig(*current_position())
  when "^"
    "up"
  when ">"
    "right"
  when "v"
    "down"
  when "<"
    "left"
  end
end

def move_up
  current_position = current_position()
  obstacle_positions = obstacle_positions()
  next_position = [current_position[0]-1, current_position[1]]

  if !obstacle_positions.include?(next_position)
    @local_map[current_position[0]][current_position[1]] = "X"
    return false if next_position[0] < 0 || next_position[0] > MAX_Y || next_position[1] < 0 || next_position[1] > MAX_X
    @local_map[next_position[0]][next_position[1]] = "^"
    true
  else
    false
  end
end

def move_right
  current_position = current_position()
  obstacle_positions = obstacle_positions()
  next_position = [current_position[0], current_position[1]+1]

  if !obstacle_positions.include?(next_position)
    @local_map[current_position[0]][current_position[1]] = "X"
    return false if next_position[0] < 0 || next_position[0] > MAX_Y || next_position[1] < 0 || next_position[1] > MAX_X
    @local_map[next_position[0]][next_position[1]] = ">"
    true
  else
    false
  end
end

def move_down
  current_position = current_position()
  obstacle_positions = obstacle_positions()
  next_position = [current_position[0]+1, current_position[1]]

  if !obstacle_positions.include?(next_position)
    @local_map[current_position[0]][current_position[1]] = "X"
    return false if next_position[0] < 0 || next_position[0] > MAX_Y || next_position[1] < 0 || next_position[1] > MAX_X
    @local_map[next_position[0]][next_position[1]] = "v"
    true
  else
    false
  end
end

def move_left
  current_position = current_position()
  obstacle_positions = obstacle_positions()
  next_position = [current_position[0], current_position[1]-1]

  if !obstacle_positions.include?(next_position)
    @local_map[current_position[0]][current_position[1]] = "X"
    return false if next_position[0] < 0 || next_position[0] > MAX_Y || next_position[1] < 0 || next_position[1] > MAX_X
    @local_map[next_position[0]][next_position[1]] = "<"
    true
  else
    false
  end
end

def change_direction
  next_directions = {
    "up" => ">",
    "right" => "v",
    "down" => "<",
    "left" => "^"
  }
  current_position = current_position()
  direction = guard_direction(current_position)
  @local_map[current_position[0]][current_position[1]] = next_directions[direction]
end

file = File.read("input_day_6.txt")
# file = File.read("sample_6.txt")
@local_map = file.split("\n").map(&:chars)
current_position = current_position()
MAX_Y = @local_map.length - 1
MAX_X = @local_map[0].length - 1

while true
  unless send(:"move_#{guard_direction(current_position)}")
    if current_position().empty?
      break
    else
      change_direction
    end
  end
end

# File.write "saida.txt", @local_map.map { |a| p a.join }.join("\n")
puts @local_map.flatten.count("X")
