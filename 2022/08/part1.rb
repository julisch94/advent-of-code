require_relative '../read_input'
require 'matrix'

lines = read_input('2022/08/input.txt')

def fill_matrix(matrix, lines)
  lines.each_with_index do |line, row|
    line.split("").each_with_index do |symbol, col|
      matrix[row, col] = symbol
    end
  end
  return matrix
end

def count_edge_trees(matrix)
  height = matrix.row_count
  width = matrix.column_count
  return 2 * height + 2 * width - 4
end

def visible?(row, col, matrix)
  visible_from_top = true
  for i in 0..row-1 do
    if matrix[i, col] >= matrix[row, col]
      visible_from_top = false
      break
    end
  end

  visible_from_left = true
  for i in 0..col-1 do
    if matrix[row, i] >= matrix[row, col]
      visible_from_left = false
      break
    end
  end

  visible_from_bottom = true
  for i in row+1..matrix.row_count-1 do
    if matrix[i, col] >= matrix[row, col]
      visible_from_bottom = false
      break
    end
  end

  visible_from_right = true
  for i in col+1..matrix.column_count-1 do
    if matrix[row, i] >= matrix[row, col]
      visible_from_right = false
      break
    end
  end

  return visible_from_top || visible_from_left || visible_from_bottom || visible_from_right
end

rows = lines.length
cols = lines[0].length

forrest = Matrix.build(rows, cols) {0}
forrest = fill_matrix(forrest, lines)

count = 0
count += count_edge_trees(forrest)

for row in 1..rows-2 do
  for col in 1..cols-2 do
    if visible?(row, col, forrest)
      count += 1
    end
  end
end

puts count