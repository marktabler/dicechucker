module Dicechucker

  class Diesheet
    attr_accessor :diesets

    def initialize(diesets = {})
      @diesets = {}
      diesets.each do |key, value|
        @diesets[key] = Dicechucker.parse(value)
      end
    end

    def [](key)
      @diesets[key]
    end

    def add(key, dieset)
      @diesets[key] = Dicechucker.parse(dieset)
    end

    def remove(key)
      @diesets.delete(key)
    end
    
    def roll
      @diesets.each_value do |value|
        value.roll
      end
    end

    def results
      to_s
    end
        
    def to_s
      output = ""
      @diesets.each do |key, value|
        output << "#{key.to_s} = #{value.total.to_s}\n"
      end
      output
    end

  end
end
