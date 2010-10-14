require 'helper'

class TestDice < MiniTest::Unit::TestCase
  include Dicechucker

  def setup

  end

  def teardown
    
  end
  
  
  def test_dice_parse_single_explicit
    first = DieSingle.new(1, 20, 0)
    second = Dicechucker.parse('1d20')
    assert_equal first, second
  end
  
  def test_dice_parse_single_implied
    first = DieSingle.new(1, 20, 0)
    second = Dicechucker.parse('20')
    assert first == second
  end
  
  def test_dice_parse_instructions
    exploder = Dicechucker.parse('6d10E')
    drop_low = Dicechucker.parse('4d6L')
    drop_high = Dicechucker.parse('4d3H+2')
    assert_equal exploder.class, Dicechucker::DiceExplode
    assert_equal drop_low.class, Dicechucker::DiceDropLow
    assert_equal drop_high.class, Dicechucker::DiceDropHigh
  end

  def test_dice_parse_plural_negative_mod
    first = Dice.new(2, 20, -4)
    second = Dicechucker.parse('2d20-4')
    assert_equal first, second
  end

  def test_dice_parse_large_numbers
    first = Dice.new(300, 5000, 2000)
    second = Dicechucker.parse('300d5000+2000')
    assert_equal first, second
  end
  
  def test_die_roll_single
    testroll = Dice.new(1, 6, 0)
    testroll.stubs(:rand => 0.5)
    assert_equal testroll.roll, 4
  end

  def test_dice_roll_plural
    testroll = Dice.new(2, 6, 0)
    testroll.stubs(:rand => 0.5)
    assert_equal testroll.roll, 8
  end

  def test_dice_average_plural_mod
    testroll = Dice.new(2, 6, 2)
    testroll.stubs(:rand => 0.5)
    assert_equal testroll.roll, 10
  end

  def test_dice_roll_report
    testroll = Dice.new(2, 20, 4)
    testroll.stubs(:rand => 0.5)
    testroll.roll
    result = testroll.report
    sample = 'rolled 11, 11 plus 4 for a total of 26.'
    assert_equal result, sample
  end

  def test_dice_drop_low
    testroll = Dicechucker.parse('4d6L')
    testroll.stubs(:rand => 0.5)
    testroll.roll
    assert_equal testroll.total, 12
    assert_equal testroll.dropped, 4
    assert_equal testroll.report, 'rolled 4, 4, 4 for a total of 12. Dropped 4.'
  end

  def test_single_die_report
    testroll = Dicechucker.parse('20')
    testroll.stubs(:rand => 0.5)
    testroll.roll
    assert_equal testroll.report, 'rolled 11.'
  end

end

