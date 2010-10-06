module Dieroller
  module GameLogic

    def check_dc(dc)
      if self.roll > dc
        true
      else
        false
      end
    end
    
    def explode(individual_rolls = false)
      dice = roll_dice
      dice.each do |roll|
        if roll == @size
          dice << (rand(@size)+1)
        end
      end
      report(dice, individual_rolls) 
    end
    
    def drop_high(number_to_drop = 1, individual_rolls = false)
      dice = roll_dice
      dice.sort!
      number_to_drop.times {dice.pop}
      report(dice, individual_rolls)
    end
    
    def drop_low(number_to_drop = 1, individual_rolls = false)
      dice = roll_dice
      dice.sort!.reverse!
      number_to_drop.times {dice.pop}
      report(dice, individual_rolls)
    end

  end
end
