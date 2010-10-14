require 'helper'

class TestDice < MiniTest::Unit::TestCase
  include Dicechucker

  def test_diesheet_initialize
    warrior_dice = Diesheet.new({'STR' => '4d6L',
                                  'DEX' => '4d6L',
                                  'CON' => '4d6L',
                                  'INT' => '4d6L',
                                  'WIS' => '4d6L',
                                  'CHA' => '4d6L',
                                  'HP' => '1d10+3'})
    assert_equal warrior_dice.diesets['STR'].class, DiceDropLow
    assert_equal warrior_dice.diesets['HP'].class, Dice
  end

  def test_diesheet_add
    warrior_dice = Diesheet.new
    ['STR', 'DEX', 'CON', 'INT', 'WIS', 'CHA'].each do |stat|
      warrior_dice.add(stat, '4d6L')
    end
    warrior_dice.add('HP', '1d10+3')
    assert_equal warrior_dice.diesets['STR'].class, DiceDropLow
    assert_equal warrior_dice.diesets['HP'].class, Dice
  end
  
  
end