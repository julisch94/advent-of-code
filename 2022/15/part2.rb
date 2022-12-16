require_relative '../read_input'

lines = read_input('2022/15/input.txt')

puts lines
puts "--"

max=4000000

def measure_distance(point_a, point_b)
  diff(point_a[0], point_b[0]) + diff(point_a[1], point_b[1])
end

def diff(a, b)
  (a - b).abs
end

measurements = []

class Measurement
  def initialize(sensor, beacon)
    @sensor = sensor
    @beacon = beacon
    @distance = measure_distance(sensor, beacon)
  end

  attr_reader :sensor, :beacon, :distance
end

lines.each do |line|
  coordinates = line.scan(/x=-?\d+, y=-?\d+/).to_a.map{|v| [v.scan(/-?\d+/)[0].to_i, v.scan(/-?\d+/)[1].to_i]}
  sensor, beacon = coordinates
  measurements << Measurement.new(sensor, beacon)
end

(0..max).each do |y|
  puts "y=#{y}"

  covered = []

  measurements.each do |m|
    sensor = m.sensor
    distance = m.distance

    next unless y.between?(sensor[1] - distance, sensor[1] + distance)

    shift = distance - (sensor[1] - y).abs

    left_edge = [sensor[0] - shift, 0].max
    right_edge = [sensor[0] + shift, max].min

    covered << (left_edge..right_edge)
  end

  mins, maxs = covered.map(&:minmax).transpose.uniq

  mins.each do |min|
    possible_xs = maxs.select { |max| min - max == 2}
    possible_xs.each do |x|
      if covered.all? {|range| !range.cover? (x+1)}
        result = (x+1) * 4000000 + y
        puts "result is #{result}"
        return
      end
    end
  end
end