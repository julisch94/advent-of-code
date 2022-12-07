require_relative '../read_input'

lines = read_input('2022/03/input.txt')

prios = Array.new

lines.each do |line|
  length = line.length
  halfLength = length / 2
  firstHalf = line[0, halfLength]
  secondHalf = line[halfLength, length]
  puts line
  puts "#{firstHalf}|#{secondHalf}"

  wrongItem = ''
  firstHalf.split('').each do |char|
    if secondHalf.include? char then
      wrongItem = char
      break
    end
  end
  puts wrongItem

  prio = 0
  if 'A'.ord <= wrongItem.ord && wrongItem.ord <= 'Z'.ord then
    prio = wrongItem.ord - 'A'.ord + 27
  elsif 'a'.ord <= wrongItem.ord && wrongItem.ord <= 'z'.ord then
    prio = wrongItem.ord - 'a'.ord + 1
  end
  prios.push(prio)
  puts prio

end

puts "--"
puts prios.reduce(:+)