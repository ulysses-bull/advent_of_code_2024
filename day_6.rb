def current_position
  @local_map.map.with_index do |line, y|
    line.map.with_index do |char, x|
      spot = @local_map[y][x]
      if spot == "^" || spot == ">" || spot == "v" || spot == "<"
        [y,x]
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
        obstacles << [y,x]
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
  end rescue binding.irb
end

def move_up
  current_position = current_position()
  obstacle_positions = obstacle_positions()
  next_position = [current_position[0]-1, current_position[1]]
  
  if !obstacle_positions.include?(next_position)
    @local_map[current_position[0]][current_position[1]] = "X"
    return false if next_position[0] > 9 || next_position[1] > 9
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
    return false if next_position[0] > 9 || next_position[1] > 9
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
    return false if next_position[0] > 9 || next_position[1] > 9
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
    return false if next_position[0] > 9 || next_position[1] > 9
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

file = File.read("sample_6.txt")
@local_map = file.split("\n").map(&:chars)
current_position = current_position()
obstacle_positions = obstacle_positions
guard_direction = guard_direction(current_position)

while true
  unless send("move_#{guard_direction(current_position)}")
    if current_position().empty?
      break
    else
      change_direction
    end
  end
end

binding.irb
puts current_position(local_map)
