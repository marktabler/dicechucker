Dicechucker
===========

Dicechucker is a die-rolling library for Ruby that accepts standard die notation (XdY+Z). It can return results either as an integer total, an array of individual die rolls plus the modifier, or as a string describing results in English.

Installation
------------
Dicechucker is installed via a gem package: `gem install dicechucker`.

Basic Usage
-----------

Manually set a Dice object:
    foo = Dicechucker::Dice.new(number_of_dice, sides_on_die, modifier)

Parse a string to make a Dice object:
    foo = Dicechucker::Dice.parse(XdY+Z)`

Basic Rolls:
    bar = foo.roll  #total only
    bar = foo.roll(true)  #array of die rolls plus modifier
    bar = foo.roll_english  #string describing results`

Other Dice methods:
-------------------

check_dc(dc): rolls the dice and compares them to DC. Returns True if roll is greater than or equal to DC.

drop_high(number_to_drop = 1, individual_results = false): Rolls the dice, and drops the highest number_to_drop results. Returns either a total or an array of individual results.

drop_low(number_to_drop = 1, individual_results = false): Rolls the dice, and drops the lowest number_to_drop results. Returns either a total or an array of individual results.

explode(individual_results = false). Rolls the dice. For each die which has a maximum result (e.g., 6 on a d6), that result is kept and another die is rolled. Returns either a total or an array of individual results.

Examples
------
To create a die set containing three six-sided dice and a modifier of one:
    stat_dice = Dicechucker::Dice.new(3, 6, 1)

To parse standard notation for same:
    stat_dice = Dicechucker::Dice.parse('3d6+1')

To roll the dice and get a total result (assume 4, 5, 6 rolled):
    stat_dice.roll  # => 16

To roll the dice and get individual dice and the modifier back:
    stat_dice.roll(true) # => [4, 5, 6, 1]

To get a plain English result:
    stat_dice.roll_english # => 'rolled 4, 5, 6 plus one for a total of 16.'

To roll 4d6+0 and drop the low die (results assume 3, 4, 5, 6 rolled):
    easy_stat_dice = Dicechucker::Dice.parse('4d6')
    stat = easy_stat_dice.drop_low  # => 15 

Copyright
---------

Copyright (c) 2010 Mark Tabler. See LICENSE for details.
