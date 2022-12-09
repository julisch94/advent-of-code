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

current_head = Point.new("head", 0,0)
current_tail = Point.new("tail", 0,0)
visited_points = Set[current_tail.dup]

lines.each do |line|
  direction, steps = line.split(" ")
  steps = steps.to_i

  for step in 0..steps-1 do
    current_head.move(direction)

    current_tail.move_tail(current_head, direction)

    visited_points << current_tail.dup
  end
end

puts visited_points.length

