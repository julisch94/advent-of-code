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

def count_visible_trees(row, col, matrix)
  visible_on_top = row
  for i in (row-1).downto(0) do
    if matrix[i, col] >= matrix[row, col]
      visible_on_top = row - i
      break
    end
  end

  visible_on_left = col
  for i in (col-1).downto(0) do
    if matrix[row, i] >= matrix[row, col]
      visible_on_left = col - i
      break
    end
  end

  visible_on_bottom = matrix.row_count - 1 - row
  for i in row+1..matrix.row_count-1 do
    if matrix[i, col] >= matrix[row, col]
      visible_on_bottom = i - row
      break
    end
  end

  visible_on_right = matrix.column_count - 1 - col
  for i in col+1..matrix.column_count-1 do
    if matrix[row, i] >= matrix[row, col]
      visible_on_right = i - col
      break
    end
  end

  puts "#{visible_on_top} * #{visible_on_left} * #{visible_on_bottom} * #{visible_on_right}"
  return visible_on_top * visible_on_left * visible_on_bottom * visible_on_right 
end

rows = lines.length
cols = lines[0].length

forrest = Matrix.build(rows, cols) {0}
forrest = fill_matrix(forrest, lines)

max = 0

for row in 1..rows-2 do
  for col in 1..cols-2 do
    max = [max, count_visible_trees(row, col, forrest)].max
  end
end

puts max