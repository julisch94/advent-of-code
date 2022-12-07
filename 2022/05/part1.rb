
require_relative '../read_input'

lines = read_input('2022/05/input.txt', false)

puts lines
puts "--"

stacks = lines.slice(0, lines.index("\n"))
procedure = lines.slice(lines.index("\n")+1..lines.length)

indicesRow = stacks.last
num_of_columns = indicesRow.split(' ').max.to_i

crates = []

height_of_stacks = stacks.length - 1

for col in 1..num_of_columns do
  index = indicesRow.index col.to_s
  crate = Array.new
  for row in (height_of_stacks-1).downto(0) do
    if stacks[row][index] != " " then
      crate.push(stacks[row][index])
    end
  end
  crates.push(crate)
end

procedure.each do |step|
  _, count, from, to = step.split(/move|from|to/).map(&:strip).map(&:to_i)
  for time in 0..count-1 do
    poppedElement = crates[from-1].pop()
    crates[to-1].push(poppedElement)
  end
end

puts crates.reduce("") { |result, crate| result += crate.last }