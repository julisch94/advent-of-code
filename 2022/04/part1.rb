require_relative '../read_input'

lines = read_input('2022/04/input.txt')

puts lines

count = 0

lines.each do |line|
  elves = line.split(',')

  elf_0 = elves[0].split('-').map(&:to_i)
  elf_1 = elves[1].split('-').map(&:to_i)
  
  puts "#{elf_0}, #{elf_1}"

  if elf_0[0] <= elf_1[0] && elf_0[1] >= elf_1[1] then
    puts "#{elf_0} is surrounding #{elf_1}"
    count += 1
  elsif elf_1[0] <= elf_0[0] && elf_1[1] >= elf_0[1] then
    puts "#{elf_1} is surrounding #{elf_0}"
    count += 1
  end
end

puts count

# 625 wrong too high