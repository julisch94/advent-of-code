require_relative '../read_input'

lines = read_input('2022/11/test.txt')

monkeys = []

class Monkey

  attr_reader :name, :items, :inspected, :divider

  def initialize(lines)
    @name = lines[0].match(/\d/).to_s.to_i

    @items = lines[1].scan(/\d+/).map(&:to_s).map(&:to_i)

    @operation_string = lines[2].split("Operation: new = ")[1]

    @divider = lines[3].split("divisible by ")[1].to_i

    @monkey_true = lines[4].split("If true: throw to monkey ")[1].to_i
    @monkey_false = lines[5].split("If false: throw to monkey ")[1].to_i

    @inspected = 0
  end

  def push_item(item)
    @items.push(item)
  end

  def take_turn(monkeys, factor)
    while !@items.empty?
      item = @items.shift()
      @inspected += 1
    
      item = perform_operation(item)

      # reduce worry
      while item > factor
        item %= factor
      end

      is_divisible = make_divisible_test(item)

      if is_divisible
        throw_item_to_monkey(monkeys, item, @monkey_true)
      else
        throw_item_to_monkey(monkeys, item, @monkey_false)
      end
    end
  end

  def throw_item_to_monkey(monkeys, item, monkey_number)
    monkeys[monkey_number].push_item(item)
  end

  def make_divisible_test(item)
    return item % @divider == 0
  end

  def divide_by_three(item)
    return item / 3
  end

  def perform_operation(item)
    if @operation_string.include?("* old")
      return item * item
    elsif @operation_string.include?("*")
      amount = @operation_string.split("* ")[1].to_s.to_i
      return item *= amount
    elsif @operation_string.include?("+")
      amount = @operation_string.split("+ ")[1].to_s.to_i
      return item += amount
    end
    return -1
  end

end


monkey_lines = []
lines.each do |line|
  if (line == "")
    m = Monkey.new(monkey_lines)
    monkeys.push(m)
    monkey_lines = []
  else
    monkey_lines << line
  end
end

m = Monkey.new(monkey_lines)
monkeys.push(m)

factor = monkeys.reduce(1) {|factor, monkey| factor *= monkey.divider}

10000.times do |round|
  monkeys.each do |monkey|
    monkey.take_turn(monkeys, factor)
  end
end

inspected = monkeys.map {|monkey| monkey.inspected}
highest = inspected.sort[-1]
second_highest = inspected.sort[-2]
puts highest * second_highest
