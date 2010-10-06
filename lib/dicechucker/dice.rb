require File.expand_path('../game_logic.rb', __FILE__)

module Dicechucker
  class NotationError < ArgumentError
  end
  
  class Dice
    include GameLogic
    
    PATTERN = /^(?:(?<dice>\d+)d)?(?<size>\d+)(?<mod>[+\-]\d+)?$/
    attr_accessor :dice, :size, :mod

    def ==(other)
      @dice == other.dice && @size == other.size && @mod == other.mod
    end
    
    def initialize(dice, size, mod)
      @dice = dice
      @size = size
      @mod = mod
    end

    def roll(individual_rolls = false)
      dice = roll_dice
      report(dice, individual_rolls)
    end

    def roll_english
      dice = roll_dice
      total = dice.inject(:+) + @mod
      dice = dice.join(', ')
      if @mod > 0
        mod_english = "plus #{@mod} "
      elsif @mod < 0
        mod_english = "minus #{@mod.abs} "
      else
        mod_english = ''
      end
      "rolled #{dice} #{mod_english}for a total of #{total}."
    end
        
    def self.parse(raw)
      if raw.match(PATTERN)
        match = raw.match(PATTERN)
        dice = Integer(match[:dice]) rescue 1
        size = Integer(match[:size]) 
        mod = Integer(match[:mod]) rescue 0
        Dice.new(dice, size, mod)
      else
        raise NotationError.new "Invalid die notation, #{raw}"
      end
    end

    private

    def report(dice, individual_rolls)
      if individual_rolls
        dice << @mod
      else
        dice = dice.inject(:+) + @mod
      end
      dice
    end
    
    def roll_dice
      results = []
      @dice.times { results.push((rand * @size + 1).to_i) }
      results
    end
  end
end

