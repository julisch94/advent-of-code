require_relative '../read_input'

module Day06
  def solve(filename)
    puts "hello world"
    line = read_input(__dir__ + "/" + filename)[0]

    puts line

    running_range = line[0..3]

    are_all_different(running_range)
    for end_index in 3..line.length-1 do
      candidate = line[end_index-3..end_index]
      puts candidate
      if are_all_different(candidate)
        return end_index + 1
      end
    end

    return -1
  end

  def solve2(filename)
    line = read_input(__dir__ + "/" + filename)[0]

    puts line

    length = 14
    running_range = line[0..length - 1]

    are_all_different(running_range)
    for end_index in length-1..line.length-1 do
      candidate = line[end_index-length+1..end_index]
      puts candidate
      if are_all_different(candidate)
        return end_index + 1
      end
    end

    return -1
  end

  def are_all_different(symbols)
    return symbols.each_char.tally.length == symbols.length
  end
end

include Day06
puts solve2('input.txt')
