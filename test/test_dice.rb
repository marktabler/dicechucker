require 'helper'

class TestDice < MiniTest::Unit::TestCase
  include Dicechucker

  def setup
    Dice.any_instance.stubs(:rand => 0.5)
  end
  
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
    assert_equal testroll.roll, 4
    
  end

  def test_dice_roll_plural
    testroll = Dice.new(2, 6, 0)
    assert_equal testroll.roll, 8
  end

  def test_dice_average_plural_mod
    testroll = Dice.new(2, 6, 2)
    assert_equal testroll.roll, 10
  end

  def test_dice_roll_english
    testroll = Dice.new(2, 20, 4)
    result = testroll.roll_english
    sample = 'rolled 11, 11 plus 4 for a total of 26.'
    assert_equal result, sample
  end

end
