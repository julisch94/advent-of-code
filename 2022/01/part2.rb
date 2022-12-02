require_relative '../read_input'

lines = read_input('2022/01/test.txt')

def evaluate_elf (currentElf, topThreeElves)
  topThreeElves.push(currentElf)
  topThreeElves.sort!
  topThreeElves.reverse!
  topThreeElves.first(3)
end

topThreeElves = Array.new
currentElf = 0
lines.each do |line|
  if line != '' then
    currentElf += line.to_i
  else 
    # change of elves
    puts "elf done: #{currentElf}"
    topThreeElves = evaluate_elf(currentElf, topThreeElves)

    currentElf = 0
  end
end
puts "elf done: #{currentElf}"
topThreeElves = evaluate_elf(currentElf, topThreeElves)

puts topThreeElves
puts "--"
puts topThreeElves.reduce(:+)
