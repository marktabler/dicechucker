require 'helper'

class TestDice < MiniTest::Unit::TestCase
  include Dicechucker

  def setup
    Dice.any_instance.stubs(:rand => 0.5)
  end
  
  def test_dice_parse_single_explicit
    first = Dice.new(1, 20, nil, 0)
    second = Dice.parse('1d20')
    assert_equal first, second                     
  end
  

  def test_dice_parse_single_implied
    first = Dice.new(1, 20, nil, 0)
    second = Dice.parse('20')
    assert_equal first, second
  end
  
  def test_dice_parse_instructions
    exploder = Dice.parse('6d10E')
    drop_low = Dice.parse('4d6L')
    drop_high = Dice.parse('4d3H+2')
    assert_equal exploder, Dice.new(6, 10, 'E', 0)
    assert_equal drop_low, Dice.new(4, 6, 'L', 0)
    assert_equal drop_high, Dice.new(4, 3, 'H', 2)
  end

  def test_dice_parse_plural_positive_mod
    first = Dice.new(2, 20, nil, -4)
    second = Dice.parse('2d20-4')
    assert_equal first, second
  end

  def test_dice_parse_large_numbers
    first = Dice.new(300, 5000, nil, 2000)
    second = Dice.parse('300d5000+2000')
    assert_equal first, second
  end
  
  def test_dice_average_single
    testroll = Dice.new(1, 6, nil, 0)
    assert_equal testroll.roll, 4
  end

  def test_dice_roll_plural
    testroll = Dice.new(2, 6, nil, 0)
    assert_equal testroll.roll, 8
  end

  def test_dice_average_plural_mod
    testroll = Dice.new(2, 6, nil, 2)
    assert_equal testroll.roll, 10
  end

  def test_dice_roll_english
    testroll = Dice.new(2, 20, nil, 4)
    result = testroll.roll_english
    sample = 'rolled 11, 11 plus 4 for a total of 26.'
    assert_equal result, sample
  end

end

