lines = Array.new

File.readlines('2021/01/input.txt').each do |line|
  lines.push(line)
end

# lines = lines.last(10)

current = nil
counter = 0

lines.each do |line|
  line = line.strip
  output = line

  if current == nil then
    output += " (N/A - no previous measurement)"
  else 
    if line > current then
      output += " (increased)"
      counter += 1
    elsif line < current then
      output += " (decreased)"
    else 
      output += " ... wow, they're equal!"
    end
  end

  puts output
  current = line
end

puts counter

