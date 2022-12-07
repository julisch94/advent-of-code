require 'test/unit'

require_relative "solve"
include Day06

class TestMySolution < Test::Unit::TestCase 
  test "solve" do
    assert_equal(7, solve('test1.txt'))
    assert_equal(5, solve('test2.txt'))
    assert_equal(6, solve('test3.txt'))
    assert_equal(10, solve('test4.txt'))
    assert_equal(11, solve('test5.txt'))
  end

  test "solve2" do
    assert_equal(19, solve2('test1.txt'))
    assert_equal(23, solve2('test2.txt'))
    assert_equal(23, solve2('test3.txt'))
    assert_equal(29, solve2('test4.txt'))
    assert_equal(26, solve2('test5.txt'))
  end

  test "are all different" do 
    assert(are_all_different('acbd'))
    assert(are_all_different('erft'))
    assert_false(are_all_different('abcb'))
    assert_false(are_all_different('ioui'))
    assert_false(are_all_different('uuuu'))
    assert_false(are_all_different('Uuiu'))
    assert_false(are_all_different('poll'))
  end
end