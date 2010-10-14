Dicechucker
===========

Dicechucker is a die-rolling library for Ruby that accepts standard
dice notation (XdYS+Z). S is a fairly new pattern for dice notation
that refers to special instructions; typically this is either L for
'drop low' or H for 'drop high'. Dicechucker also supports E for
'explode'. 

Dicechucker also supports Diesheets, which are collections of diesets
that can be rolled together. For example, a standard d20 first-level
character requires seven rolls: one for each of six basic stats, and
one for hit points. A diesheet can define all seven rolls, so that
you can generate an entire character all at once.


Installation
------------
Dicechucker is installed via a gem package: `gem install dicechucker`.

Basic Usage
-----------

Please note that usage has changed significantly since the initial
0.6.0 release:

Manually set a generic Dice object (deprecated; use Dicechucker.parse instead):
    foo = Dicechucker::Dice.new(number_of_dice, sides_on_die, modifier)

Parse a string to make a Dice object:
    foo = Dicechucker.parse(XdYS+Z)

Rolling and getting results:
    bar = foo.roll  #rolls the dice and gives you a total
    bar = foo.results  #gives you an array of individual rolls
    bar = foo.total #gives you the total roll without re-rolling
    bar = foo.report  #gives you an english description without re-rolling
    bar = foo.modifier  #gives you only the modifier for the dieset
    foo.roll  # just rolls the dice
              # total, results, and report now have different output

Other Dice Behaviors:
-------------------

Dicechucker imbeds special instructions into the dieset, so that you
don't need to do anything except .roll the dice. 

Examples
------
Make a dieset comprised of three six-sided dice, with the total
modified by +1:
    stat_dice = Dicechucker.parse('3d6+1')

To roll the dice and get a total (assume 4, 5, 6 rolled):
    my_roll = stat_dice.roll  # => 16

To see the individual rolls that got you that total:
    stat_dice.results # => [4, 5, 6]

To get a plain English result:
    stat_dice.report # => 'rolled 4, 5, 6 plus one for a total of 16.'

To roll 4d6+0 and drop the low die (results assume 3, 4, 5, 6 rolled):
    easy_stat_dice = Dicechucker.parse('4d6L')
    stat = easy_stat_dice.roll  # => 15 

If you want to see what the dropped die was:
    easy_stat_dice.dropped # => 3

Diesheets:
----------

Diesheets are hash-based for your dice-chucking convenience. 

To set up a die sheet for a standard d20 warrior:
    warrior = Dicechucker::Diesheet.new({
        "STR" => "4d6L"
        "DEX" => "4d6L"
        "CON" => "4d6L"
        "INT" => "4d6L"
        "WIS" => "4d6L"
        "CHA" => "4d6L"
        "HP"  => "1d10" })
    puts warrior  
        # Gives you the results...
        #STR = 14
        #DEX = 12
        #CON = 15
        #etc...

Diesheets also support .add to add a dieset, so the above example can
be shortened greatly:
    warrior = Dicechucker::Diesheet.new
    ['STR', 'DEX', 'CON', 'INT', 'WIS', 'CHA'].each do |stat|
      warrior.add(stat, '4d6L')
    end
    warrior.add('HP', '1d10')
    puts warrior

Diesheets are rolled automatically when created, when a dieset is
added, and when a dieset is removed. 


Copyright
---------

Copyright (c) 2010 Mark Tabler. See LICENSE for details.
