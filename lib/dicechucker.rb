module Dicechucker
  autoload :Diesheet,  File.expand_path('../dicechucker/diesheet.rb', __FILE__)
  autoload :Dice,         File.expand_path('../dicechucker/dice.rb', __FILE__)
  autoload :DieSingle,    File.expand_path('../dicechucker/dice.rb', __FILE__)
  autoload :DiceDropHigh, File.expand_path('../dicechucker/dice.rb', __FILE__)
  autoload :DiceDropLow,  File.expand_path('../dicechucker/dice.rb', __FILE__)
  autoload :DiceExplode,  File.expand_path('../dicechucker/dice.rb', __FILE__)


  class NotationError < ArgumentError
  end
  
  PATTERN = /^(?:(?<dice>\d+)d)?(?<size>\d+)(?<logic>[eEhHlL])?(?<mod>[+\-]\d+)?$/
  
  def self.parse(raw, reportstyle = :total_only)
    if (match = raw.match(PATTERN))
      dice = Integer(match[:dice]) rescue 1
      size = Integer(match[:size]) 
      mod = Integer(match[:mod]) rescue 0
      logic = String(match[:logic]) rescue nil
      dieset = make_dice(dice, size, logic, mod)
      dieset.roll
      dieset
    else
      raise NotationError, "Invalid die notation, #{raw}"
    end
  end
  
  def self.make_dice(dice, size, logic, mod)
    case logic.upcase
    when 'L'
      return DiceDropLow.new(dice, size, mod)
    when 'H'
      return DiceDropHigh.new(dice, size, mod)
    when 'E'
      return DiceExplode.new(dice, size, mod)
    end
    if dice == 1 and mod == 0
      return DieSingle.new(dice, size, mod)
    end
    return Dice.new(dice, size, mod)
  end
  

end
