require_relative '../read_input'

lines = read_input('2022/04/input.txt')

puts lines

count = 0

lines.each do |line|
  elves = line.split(',')

  elf_0 = elves[0].split('-').map(&:to_i)
  elf_1 = elves[1].split('-').map(&:to_i)
  
  puts "#{elf_0}, #{elf_1}"

  if elf_0[0] <= elf_1[0] && elf_1[0] <= elf_0[1] then
    count += 1
    puts "#{elf_1} starts within #{elf_0}"
  elsif elf_0[0] <= elf_1[1] && elf_1[1] <= elf_0[1] then
    count += 1
    puts "#{elf_1} ends within #{elf_0}"
  elsif elf_1[0] <= elf_0[0] && elf_0[0] <= elf_1[1] then
    count += 1
    puts "#{elf_0} starts within #{elf_1}"
  elsif elf_1[0] <= elf_0[1] && elf_0[1] <= elf_1[1] then
    count += 1
    puts "#{elf_0} ends within #{elf_1}"
  end

end

puts count
