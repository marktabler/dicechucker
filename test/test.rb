require '../lib/dieroller/dieroller.rb'
require 'minitest/unit'
MiniTest::Unit.autorun


class Testroll < MiniTest::Unit::TestCase
include Dieroller
  def test_dieroll_parse_single_implied
    first = Dieroll.new(1, 20, 0)
    second = Dieroll.parse('20')
    assert_equal first, second
  end
  
  def test_dieroll_parse_plural_positive_mod
    first = Dieroll.new(2, 20, -4)
    second = Dieroll.parse('2d20-4')
    assert_equal first, second
  end

  def test_dieroll_parse_large_numbers
    first = Dieroll.new(300, 5000, 2000)
    second = Dieroll.parse('300d5000+2000')
    assert_equal first, second
  end
  
  def test_dieroll_average_single
    testroll = Dieroll.new(1, 6, 0)
    result = 0
    1000000.times do
      result += testroll.roll
    end
    average = result / 1000000.0
    assert average > 3.45 and average < 3.55
  end

  def test_dieroll_average_plural
    testroll = Dieroll.new(2, 6, 0)
    result = 0
    1000000.times do
      result += testroll.roll
    end
    average = result / 1000000.0
    assert average > 6.95 and average < 7.05
  end

  def test_dieroll_average_plural_mod
    testroll = Dieroll.new(2, 6, 2)
    result = 0
    1000000.times do
      result += testroll.roll
    end
    average = result / 1000000.0
    assert average > 8.95 and average < 10.05
  end

  def test_roll_verbose
    testroll = Dieroll.new(2, 1, -3)
    result = testroll.roll(true)
    sample = 'Rolled 1 1 minus 3 for a result of -1'
    assert_equal result, sample
  end
end
