require_relative '../read_input'

lines = read_input('2022/15/input.txt')

puts lines
puts "--"

def measure_distance(point_a, point_b)
  diff(point_a[0], point_b[0]) + diff(point_a[1], point_b[1])
end

def diff(a, b)
  (a - b).abs
end

class Measurement
  def initialize(sensor, beacon)
    @sensor = sensor
    @beacon = beacon
    @distance = measure_distance(sensor, beacon)
  end

  attr_reader :sensor, :beacon, :distance
end

measurements = []

lines.each do |line|
  coordinates = line.scan(/x=-?\d+, y=-?\d+/).to_a.map{|v| [v.scan(/-?\d+/)[0].to_i, v.scan(/-?\d+/)[1].to_i]}
  sensor, beacon = coordinates
  measurements << Measurement.new(sensor, beacon)
end

y = 2000000

covered = []

measurements.each do |m|
  sensor = m.sensor
  distance = m.distance

  next unless y.between?(sensor[1] - distance, sensor[1] + distance)

  shift = distance - (sensor[1] - y).abs

  left_edge = sensor[0] - shift
  right_edge = sensor[0] + shift

  covered << (left_edge..right_edge)
end

covered = covered.map(&:to_a).flatten.sort.uniq

measurements.each do |m|
  beacon = m.beacon
  if beacon[1] == y
    covered.delete(beacon[0])
  end
end

puts "y=#{y} #{covered.length}"