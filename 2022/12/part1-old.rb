require_relative '../read_input'
require 'matrix'

lines = read_input('2022/12/input.txt')

puts lines

def fill_matrix(matrix, lines)
  lines.each_with_index do |line, row|
    line.split("").each_with_index do |symbol, col|
      matrix[row, col] = symbol
    end
  end
  return matrix
end

rows = lines.length
cols = lines[0].length

heightmap = Matrix.build(rows, cols) {0}
heightmap = fill_matrix(heightmap, lines)

puts heightmap

start = heightmap.index("E")
finish = heightmap.index("S")

def is_in_bounds?(position, matrix)
  y = position[0]
  x = position[1]

  max_y = matrix.row_count - 1
  max_x = matrix.column_count - 1

  if (x < 0 || y < 0 || x > max_x || y > max_y)
    return false
  end

  return true
end

def is_move_okay?(first, second)
  if (first == "S")
    first = "a"
  end
  if (second == "E")
    second = "z"
  end

  is_okay = second.ord - first.ord == 1 || second.ord - first.ord == 0
end

def has_been_visited_before?(position, path)
  path.any? {|pos| position[0] == pos[0] && position[1] == pos[1]}
end

def find_possible_paths(start, finish, current_path, matrix)
  y = start[0]
  x = start[1]
  value = matrix[y, x]

  if (value == "S") 
    puts "arrived at destination! #{start}"
    return [current_path]
  end
 
  look_around = [[y-1, x], [y+1, x], [y, x-1], [y, x+1]]

  paths = []
  look_around.each do |position|
    next_value = matrix[position[0], position[1]]
    puts "#{position}: #{next_value}"

    if !is_in_bounds?(position, matrix)
      puts "#{position} is out of bounds"
      next
    end

    if has_been_visited_before?(position, current_path)
      next
    end

    if (!is_move_okay?(next_value, value))
      puts "#{value} -> #{next_value}: too steep!"
      next
    end

    puts "making move #{value} -> #{next_value}"
    new_path = current_path.dup
    new_path << position
    
    possible_paths = find_possible_paths(position, finish, new_path, matrix)
    # puts "possible paths: #{possible_paths}"
    possible_paths.each {|path| paths << path}
  end
  
  # puts "paths: #{paths}"
  return paths
end

paths = find_possible_paths(start, finish, [start], heightmap)
# puts "#{paths}"

min = paths[0].length
shortest = paths[0]
paths.each do |path|
  if path.length < min
    min = path.length
    shortest = path
  end
end

puts min - 1
puts "#{shortest}"
