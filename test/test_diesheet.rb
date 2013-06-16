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

  def test_diesheet_remove
    dummy_dice = Diesheet.new('First' => '2d6', 'Second' => '2d6')
    dummy_dice.remove('Second')
    assert_equal dummy_dice['Second'], nil
    assert_equal dummy_dice['First'].class, Dice
  end

  def test_diesheet_accessibility
    warrior_dice = Diesheet.new
    ['STR', 'DEX', 'CON', 'INT', 'WIS', 'CHA'].each do |stat|
      warrior_dice.add(stat, '4d6L')
    end
    warrior_dice.add('HP', '1d10+3')
    assert_equal warrior_dice['STR'].class, DiceDropLow
    assert_equal warrior_dice['HP'].class, Dice
    assert_equal warrior_dice['STR'].total.class, Fixnum
    assert_equal warrior_dice['STR'].results.class, Array
  end

  def test_diesheet_roll
    dummydice = Diesheet.new('First' => '1d6', 'Second' => '1d6')
    dummydice.roll
  end

  def test_diesheet_to_s
    dummydice = Diesheet.new('First' => '1d6', 'Second' => '2d6')
    output = dummydice.to_s
    assert_equal output.class, String
  end

end
