require_relative '../read_input'

lines = read_input('2022/10/input.txt')

register_series = [1]
lines.each do |line|
  current = register_series.last
  if line == "noop"
    register_series.push(current)
  elsif line.start_with?("addx")
    # wait one cycle
    register_series.push(current)

    # finish add operation
    value = line.split(" ")[1].to_i
    register_series.push(current + value)
  end
end

signal_strength = 0
[20, 60, 100, 140, 180, 220].each do |cycles|
  value = register_series[cycles-1]
  signal_strength += cycles * value
end

puts signal_strength
