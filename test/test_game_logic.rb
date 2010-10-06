require 'helper'

class TestLogic < MiniTest::Unit::TestCase
  include Dicechucker

  def setup
    Dice.any_instance.stubs(:rand => 0.5)
  end

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
    assert_equal result.size, 101 #all random rolls are 4, nothing explodes
  end

  def test_check_dc
    testroll = Dice.new(1, 20, 2)
    assert testroll.check_dc(14) == false
    assert testroll.check_dc(13) == true
  end
end
