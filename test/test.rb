require '../lib/dieroller.rb'
require '../lib/game_logic.rb'
require 'minitest/unit'
require 'mocha'
MiniTest::Unit.autorun


class Test_Dice < MiniTest::Unit::TestCase
  include Dieroller
  
  def test_dice_parse_single_implied
    first = Dice.new(1, 20, 0)
    second = Dice.parse('20')
    assert_equal first, second
  end
  
  def test_dice_parse_plural_positive_mod
    first = Dice.new(2, 20, -4)
    second = Dice.parse('2d20-4')
    assert_equal first, second
  end

  def test_dice_parse_large_numbers
    first = Dice.new(300, 5000, 2000)
    second = Dice.parse('300d5000+2000')
    assert_equal first, second
  end
  
  def test_dice_average_single
    testroll = Dice.new(1, 6, 0)
    result = 0
    100000.times do
      result += testroll.roll
    end
    average = result / 100000.0
    assert average > 3.2 and average < 3.7
  end

  def test_dice_average_plural
    testroll = Dice.new(2, 6, 0)
    result = 0
    100000.times do
      result += testroll.roll
    end
    average = result / 100000.0
    assert average > 6.8 and average < 7.2
  end

  def test_dice_average_plural_mod
    testroll = Dice.new(2, 6, 2)
    result = 0
    100000.times do
      result += testroll.roll
    end
    average = result / 100000.0
    assert average > 8.8 and average < 9.2
  end

  def test_dice_roll_english
    testroll = Dice.new(2, 1, -3)
    result = testroll.roll_english
    sample = 'rolled 1, 1 minus 3 for a total of -1.'
    assert_equal result, sample
  end

end

class Test_Logic < MiniTest::Unit::TestCase
  include Dieroller

  def test_dice_drop_low
    testroll = Dice.new(100, 6, 0)
    result = testroll.drop_low(10, true)
    assert_equal result.size, 91 #90 dice plus 1 modifier of 0
  end

  def test_dice_drop_high
    testroll = Dice.new(100, 6, 0)
    result = testroll.drop_high(10, true)
    assert_equal result.size, 91 #90 dice plus 1 modifier of 0
  end

  def test_explode
    testroll = Dice.new(100, 6, 0)
    result = testroll.explode(true)
    assert result.size > 100
  end

  def test_check_dc
    testroll = Dice.new(1, 10, 20)
    assert testroll.check_dc(40) == false
    assert testroll.check_dc(5) == true
  end
  
  
end
