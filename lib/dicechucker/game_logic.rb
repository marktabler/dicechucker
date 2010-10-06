module Dicechucker
  module GameLogic

    def check_dc(dc)
      self.roll >= dc
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
      dice = roll_dice.sort.reverse.drop(number_to_drop)
      report(dice, individual_rolls)
    end
    
    def drop_low(number_to_drop = 1, individual_rolls = false)
      dice = roll_dice.sort.drop(number_to_drop)
      report(dice, individual_rolls)
    end

  end
end
