require_relative '../read_input'

puts "hello world"

lines = read_input('2022/02/input.txt')

def calcScoreOfWin (sign)
  if sign == "X"
    return 0
  elsif sign == "Y"
    return 3
  elsif sign == "Z"
    return 6
  end
end

# A, X rock, 1 points
# B, Y paper, 2 points
# C, Z scissors, 3 points

def calcScoreOfSign (opponent, mine)
  if opponent == "A"
    if mine == "X"
      return 3
    elsif mine == "Y"
      return 1
    elsif mine == "Z"
      return 2
    end
  elsif opponent == "B"
    if mine == "X"
      return 1
    elsif mine == "Y"
      return 2
    elsif mine == "Z"
      return 3
    end
  elsif opponent == "C" 
    if mine == "X"
      return 2
    elsif mine == "Y"
      return 3
    elsif mine == "Z"
      return 1
    end
  end
end

totalScore = 0

lines.each do |round|
  signs = round.split(" ")

  opponent = signs[0]
  outcome = signs[1]

  winScore = calcScoreOfWin(outcome)
  signScore = calcScoreOfSign(opponent, outcome)

  puts "#{signScore} #{winScore}"
  score = winScore + signScore

  puts score
  totalScore += score
end

puts "--"
puts totalScore
