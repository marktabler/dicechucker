module Dicechucker
  autoload :Dicechucker,  File.expand_path('../dicechucker/dice.rb', __FILE__)
  autoload :Dice,         File.expand_path('../dicechucker/dice.rb', __FILE__)
  autoload :DieSingle,    File.expand_path('../dicechucker/dice.rb', __FILE__)
  autoload :DiceDropHigh, File.expand_path('../dicechucker/dice.rb', __FILE__)
  autoload :DiceDropLow,  File.expand_path('../dicechucker/dice.rb', __FILE__)
  autoload :DiceExplode,  File.expand_path('../dicechucker/dice.rb', __FILE__)
  autoload :GameLogic, File.expand_path('../dicechucker/game_logic.rb', __FILE__)
end
