module Dicechucker

  class Dice
    attr_accessor :number_of_dice, :sides, :modifier, :results, :total

    def initialize(dice, sides, modifier)
      @number_of_dice = dice
      @sides = sides
      @modifier = modifier
      roll
    end

    def roll
      roll_dice
      @total = @results.inject(:+) + @modifier
    end

    def report
      rep = 'rolled '
      rep << @results.join(', ')
      if @modifier > 0
        rep << " plus #{@modifier}"
      elsif @modifier < 0
        rep << " minus #{@modifier}"
      end
      rep << " for a total of #{@total}."
      rep
    end

    def ==(other)
      [@number_of_dice == other.number_of_dice,
       @sides == other.sides,
       @modifier == other.modifier,
       self.class == other.class].all?
    end

    private

    def roll_dice
      @results = Array.new(@number_of_dice) { (rand * @sides + 1).to_i}
    end

  end

  class DiceDropper < Dice
    attr_accessor :dropped

    def roll
      roll_dice
      @dropped = @results.delete_at(@results.index(drop_target))
      @total = @results.inject(:+) + @modifier
    end

    def report
      rep = super
      rep << " Dropped #{@dropped}."
      rep
    end

    def drop_target
      raise NotImplementedError, "drop_target must be overwritten by child classes"
      #defined only for use by subclasses
    end

  end

  class DiceDropLow < DiceDropper
    def drop_target
      @results.min
    end
  end

  class DiceDropHigh < DiceDropper
    def drop_target
      @results.max
    end
  end

  class DiceExplode < Dice
    def roll
      roll_dice
      @results.each.with_index do |roll, index|
        if roll == @sides
          @results.insert(index + 1, (rand(@sides)+1))
        end
      end
      @total = @results.inject(:+) + @modifier
    end

  end

  class DieSingle < Dice
    def report
      "rolled #{@total}."
    end
  end

end
