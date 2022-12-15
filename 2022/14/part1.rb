require_relative '../read_input'
require 'matrix'

def draw_rock_line(point_a, point_b, matrix)
  # puts "drawing rock line #{point_a} #{point_b}"
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
  # puts "drawing rock #{points}"
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
  File.open(__dir__ + '/output.txt', 'w') do |fo|
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

    matrix[y, x] = "o"
    return true
  end

  return false
end

lines = read_input('2022/14/input.txt')

width = 1000
height = 600

m = Matrix.build(height, width){"."}

lines.each do |line|
  draw_rock(line, m)
end

m[0, 500] = "+"

count = 0
loop do
  got_stuck = fill_in_one_sand(m)

  count += 1 unless !got_stuck
  break if !got_stuck
end

print_to_file(m)

puts count