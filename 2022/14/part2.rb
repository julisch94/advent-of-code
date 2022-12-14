require_relative '../read_input'
require 'matrix'

def draw_rock_line(point_a, point_b, matrix)
  x_1, y_1 = point_a
  x_2, y_2 = point_b

  if x_1 == x_2
    if y_1 < y_2
      [y_1..y_2].each {|y| matrix[y, x_1] = "#"}
    else
      [y_2..y_1].each {|y| matrix[y, x_1] = "#"}
    end
  elsif y_1 == y_2
    if x_1 < x_2
      [x_1..x_2].each {|x| matrix[y_1, x] = "#"}
    else
      [x_2..x_1].each {|x| matrix[y_1, x] = "#"}
    end
  else 
    puts "huh?"
  end
end

def draw_rock(line, matrix)
  points = line.split(" -> ").map{|c| c.split(",").map(&:to_i)}
  points.each_cons(2) do 
    |a| draw_rock_line(a[0], a[1], matrix)
  end
end

def print(matrix)
  rows = matrix.row_count
  cols = matrix.column_count
  rows.times do |row|
    line = ""
    cols.times do |col|
      line += matrix[row, col]
    end
    puts line
  end
end

def print_to_file(m)
  old_stdout = $stdout
  File.open('output.txt', 'w') do |fo|
    $stdout = fo
    print m
  end
  $stdout = old_stdout
end

def is_blocked(x, y, matrix)
  matrix[y, x] != "."
end

def fill_in_one_sand(matrix)
  x = 500
  y = 0

  while (y < matrix.row_count - 1)
    if !is_blocked(x, y+1, matrix)
      y += 1
      next
    end

    if !is_blocked(x-1, y+1, matrix)
      y += 1
      x -= 1
      next
    end

    if !is_blocked(x+1, y+1, matrix)
      y += 1
      x += 1
      next
    end

    return x, y
  end

  return x, y
end

def find_max_y(lines)
  max_y = lines.reduce(0) do |max, line|
    coordinates = line.split(" -> ")
    y_s = coordinates.map {|c| c.split(",")[1].to_i}
    [max, y_s.max].max
  end
end

lines = read_input('2022/14/input.txt')

max_y = find_max_y(lines)

width = 1000
height = max_y + 2

m = Matrix.build(height, width){"."}

lines.each do |line|
  draw_rock(line, m)
end

m[0, 500] = "+"

count = 0
loop do
  x, y = fill_in_one_sand(m)
  m[y, x] = "o"
  count += 1

  break if [x, y] == [500,0]
end

print_to_file(m)

puts count