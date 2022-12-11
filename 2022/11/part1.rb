require_relative '../read_input'

lines = read_input('2022/11/test.txt')

monkeys = []

class Monkey

  attr_reader :name, :items, :inspected

  def initialize(lines)
    @name = lines[0].match(/\d/).to_s.to_i

    @items = lines[1].scan(/\d+/).map(&:to_s).map(&:to_i)

    @operation_string = lines[2].split("Operation: new = ")[1]

    @divisible_by = lines[3].split("divisible by ")[1].to_i

    @monkey_true = lines[4].split("If true: throw to monkey ")[1].to_i
    @monkey_false = lines[5].split("If false: throw to monkey ")[1].to_i

    @inspected = 0
  end

  def push_item(item)
    @items.push(item)
  end

  def take_turn(monkeys)
    while !@items.empty?
      item = @items.shift()
      puts "\tMonkey inspects an item with a worry level of #{item}."
      @inspected += 1
    
      item = perform_operation(item)

      item = divide_by_three(item)

      is_divisible = make_divisible_test(item)

      if is_divisible
        throw_item_to_monkey(monkeys, item, @monkey_true)
      else
        throw_item_to_monkey(monkeys, item, @monkey_false)
      end
    end

  end

  private

  def throw_item_to_monkey(monkeys, item, monkey_number)
    puts "\t\tItem with worry level #{item} is thrown to monkey #{monkey_number}."
    monkeys[monkey_number].push_item(item)
  end

  def make_divisible_test(item)
    is_divisible = item % @divisible_by == 0
    if is_divisible
      puts "\t\tCurrent worry level is divisible by #{@divisible_by}."
    else
      puts "\t\tCurrent worry level is not divisible by #{@divisible_by}."
    end
    return is_divisible
  end

  def divide_by_three(item)
    new_value = item / 3
    puts "\t\tMonkey gets bored with item. Worry level is divided by 3 to #{new_value}."
    return new_value
  end

  def perform_operation(item)
    new_value = 0
    if @operation_string.include?("* old")
      new_value = item * item
      puts "\t\tWorry level is multiplied by itself to #{new_value}."
    elsif @operation_string.include?("*")
      amount = @operation_string.split("* ")[1].to_s.to_i
      new_value = item *= amount
      puts "\t\tWorry level is multiplied by #{amount} to #{new_value}."
    elsif @operation_string.include?("+")
      amount = @operation_string.split("+ ")[1].to_s.to_i
      new_value = item += amount
      puts "\t\tWorry level increases by #{amount} to #{new_value}."
    end
    return new_value
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

puts "#{monkeys}"

20.times do |round|
  monkeys.each do |monkey|
    monkey.take_turn(monkeys)
  end

  monkeys.each do |monkey|
    puts "Monkey #{monkey.name}: #{monkey.items}"
  end
end

monkeys.each do |monkey|
  puts "Monkey #{monkey.name} inspected items #{monkey.inspected} times"
end

inspected = monkeys.map {|monkey| monkey.inspected}
highest = inspected.sort[-1]
second_highest = inspected.sort[-2]
puts highest * second_highest
