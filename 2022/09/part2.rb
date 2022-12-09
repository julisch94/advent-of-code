require_relative '../read_input'
require 'set'

lines = read_input('2022/09/input.txt', false)

puts lines

class Point
  def initialize(name, x, y)
    @name = name
    @x = x
    @y = y
  end

  attr_accessor :x, :y, :name

  def move(direction)
    if direction == "R"
      @x += 1
    elsif direction == "U"
      @y += 1
    elsif direction == "L"
      @x -= 1
    elsif direction == "D"
      @y -= 1
    end
  end

  def too_far_away_from(point) 
    return (@x - point.x).abs > 1 || (@y - point.y).abs > 1
  end

  def move_tail(head_point)
    if !self.too_far_away_from(head_point)
      return
    end

    if @x < head_point.x
      @x += 1
    elsif @x > head_point.x
      @x -= 1
    end

    if @y < head_point.y
      @y += 1
    elsif @y > head_point.y
      @y -= 1
    end
  end

  def to_s
    return "#{@name} (#{@x}, #{@y})"
  end

  def eql?(other)
    self.class == other.class &&
      @x == other.x &&
      @y == other.y
  end

  def hash
    @x ^ @y
  end
end

point_h = Point.new("H", 0,0)
point_1 = Point.new("1", 0,0)
point_2 = Point.new("2", 0,0)
point_3 = Point.new("3", 0,0)
point_4 = Point.new("4", 0,0)
point_5 = Point.new("5", 0,0)
point_6 = Point.new("6", 0,0)
point_7 = Point.new("7", 0,0)
point_8 = Point.new("8", 0,0)
point_9 = Point.new("9", 0,0)
visited_points = Set[point_9.dup]

lines.each do |line|
  direction, steps = line.split(" ")
  steps = steps.to_i

  for step in 0..steps-1 do
    point_h.move(direction)
    point_1.move_tail(point_h)
    point_2.move_tail(point_1)
    point_3.move_tail(point_2)
    point_4.move_tail(point_3)
    point_5.move_tail(point_4)
    point_6.move_tail(point_5)
    point_7.move_tail(point_6)
    point_8.move_tail(point_7)
    
    point_9.move_tail(point_8, direction_8)

    visited_points << point_9.dup
  end
end

puts visited_points.length

