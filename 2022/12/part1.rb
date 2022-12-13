require_relative '../read_input'
require 'matrix'
require 'set'

lines = read_input('2022/12/input.txt')

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

matrix = Matrix.build(rows, cols) {0}
matrix = fill_matrix(matrix, lines)

start = matrix.index("S")
finish = matrix.index("E")

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

  is_okay = second.ord - first.ord <= 1
end

def has_been_visited_before?(position, path)
  path.any? {|pos| position[0] == pos[0] && position[1] == pos[1]}
end

pointers = Set.new([start])
visited = Set.new([start])
steps_taken = 0

while (!visited.include? (finish)) do
  expansion = Set.new

  pointers.each do |pointer|
    y = pointer[0]
    x = pointer[1]
    value = matrix[y, x]

    look_around = [[y-1, x], [y+1, x], [y, x-1], [y, x+1]]
    next_valid_steps = look_around.select do |step|
      if has_been_visited_before?(step, visited)
        next
      end

      if !is_in_bounds?(step, matrix)
        next
      end

      next_value = matrix[step[0], step[1]]
      if !is_move_okay?(value, next_value)
        next
      end

      next(true)
    end

    expansion.merge(next_valid_steps)
  end

  visited.merge(expansion)
  pointers = expansion.dup
  steps_taken += 1
end

puts steps_taken