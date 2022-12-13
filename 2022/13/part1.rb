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

def collect_indices_of_correct_orders(pairs)
  indices = pairs.map.with_index do |pair, index|
    left, right = pair

    if are_in_correct_order?(left, right) == $right
      index
    end
  end
  indices.compact
end

indices = collect_indices_of_correct_orders(pairs)

indices.map!(&:next)

sum = indices.reduce(:+)

puts "indices with right order: #{indices}"
puts "sum: #{sum}"
