require_relative '../read_input'
require 'json'

lines = read_input('2022/13/input.txt')

pairs = lines.each_slice(3).map do |pair|
  left, right = pair
  [JSON.parse(left), JSON.parse(right)]
end

$right = "right"
$wrong = "wrong"
$equal = "equal"

def both_integers?(first, second)
  return first.is_a?(Integer) && second.is_a?(Integer)
end

def are_integers_correct?(one, two)
  if one < two
    return $right
  elsif two < one
    return $wrong
  else
    return $equal
  end
end

def are_in_correct_order?(leftArray, rightArray)
  if leftArray.length == 0 && rightArray.length != 0
    return $right
  elsif rightArray.length == 0 && leftArray.length != 0
    return $wrong
  elsif leftArray.length == 0 && rightArray.length == 0
    return $equal
  end

  left = leftArray.first
  right = rightArray.first

  if both_integers?(left, right)
    case are_integers_correct?(left, right)
    when $right
      return $right
    when $wrong
      return $wrong
    else
      return are_in_correct_order?(leftArray[1..], rightArray[1..])
    end
  end

  left = left.is_a?(Integer) ? [left] : left
  right = right.is_a?(Integer) ? [right] : right

  case are_in_correct_order?(left, right)
  when $right
    return $right
  when $wrong
    return $wrong
  else
    return are_in_correct_order?(leftArray[1..], rightArray[1..])
  end
end

packets = pairs.reduce([]) do |list, pair| 
  list << pair[0]
  list << pair[1]
end
packets << [[2]]
packets << [[6]]

packets.sort! do |a, b|
  case
  when are_in_correct_order?(a, b) == $right
    -1
  when are_in_correct_order?(a, b) == $wrong
    1
  else
    0
  end
end

indices = packets.map.with_index do |packet, index|
  if packet.to_s == "[[2]]" || packet.to_s == "[[6]]"
    index
  end
end

indices.compact!
indices.map!(&:next)

product = indices.reduce(:*)

puts "indices: #{indices}"
puts "product: #{product}"
