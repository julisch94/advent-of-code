require_relative '../read_input'

lines = read_input('2022/01/test.txt')

currentMax = 0
currentElf = 0

lines.each do |line|
  if line != '' then
    currentElf += line.to_i
  else 
    puts "elf done: #{currentElf}"
    currentMax = [currentElf, currentMax].max
    currentElf = 0
  end
end
puts "elf done: #{currentElf}"
currentMax = [currentElf, currentMax].max

puts currentMax