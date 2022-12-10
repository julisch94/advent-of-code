require_relative '../read_input'

lines = read_input('2022/10/input.txt')

puts lines
puts "--"

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
  # puts "#{register_series.first(cycles)}"
  value = register_series[cycles-1]
  # puts "register during #{cycles}. cycle: #{value}"
  signal_strength += cycles * value
end

puts "#{register_series.first(22)}"
# puts signal_strength

register_series.each_slice(40) do |row|
  # puts "row: #{row}"
  output = ""
  row.each_with_index do |cycle, index|
    # puts "cycle #{index +1}"
    # puts "CRT draws pixel #{index}"
    # puts "Sprite is at #{cycle - 1}-#{cycle +1}"
    if cycle - 1 <= index && index <= cycle + 1
      output += "#"
    else 
      output += " "
    end
  end
  puts output
end


