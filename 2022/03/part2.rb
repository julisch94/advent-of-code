require_relative '../read_input'

lines = read_input('2022/03/input.txt')

prios = Array.new

lines.each_slice(3) do |group|
  elf_0 = group[0]
  elf_1 = group[1]
  elf_2 = group[2]

  commonItem = ''
  elf_0.split('').each do |item|
    if elf_1.include?(item) && elf_2.include?(item) then
      commonItem = item
    end
  end
  puts commonItem

  prio = 0
  if 'A'.ord <= commonItem.ord && commonItem.ord <= 'Z'.ord then
    prio = commonItem.ord - 'A'.ord + 27
  elsif 'a'.ord <= commonItem.ord && commonItem.ord <= 'z'.ord then
    prio = commonItem.ord - 'a'.ord + 1
  end
  prios.push(prio)
  puts prio
end

puts "--"
puts prios.reduce(:+)
