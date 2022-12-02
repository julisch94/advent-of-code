require_relative '../read_input'

lines = read_input('2022/02/input.txt')

def calcScoreOfWin (sign)
  if sign == "X"
    return 1
  elsif sign == "Y"
    return 2
  elsif sign == "Z"
    return 3
  end
end

# A, X rock, 1 points
# B, Y paper, 2 points
# C, Z scissors, 3 points

def calcScoreOf (opponent, mine)
  if opponent == "A"
    if mine == "Y"
      return 6
    elsif mine == "Z"
      return 0
    end
  elsif opponent == "B"
    if mine == "X"
      return 0
    elsif mine == "Z"
      return 6
    end
  elsif opponent == "C" 
    if mine == "X"
      return 6
    elsif mine == "Y"
      return 0
    end
  end

  # otherwise it was a tie
  return 3
end

totalScore = 0

lines.each do |round|
  signs = round.split(" ")

  opponent = signs[0]
  mine = signs[1]

  score = calcScoreOfWin(mine)
  score += calcScoreOf(opponent, mine)

  puts score
  totalScore += score
end

puts "--"
puts totalScore
