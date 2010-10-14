module Dicechucker

  class Diesheet
    attr_accessor :diesets, :results

    def initialize(diesets = {})
      @diesets = {}
      @results = {}
      diesets.each do |key, value|
        @diesets[key] = Dicechucker.parse(value)
        @results[key] = @diesets[key].total
      end
    end

    def add(key, dieset)
      @diesets[key] = Dicechucker.parse(dieset)
      roll
    end

    def delete(key)
      remove(key)
    end
        
    def remove(key)
      @diesets[key].delete
      roll
    end
    
    def roll
      @diesets.each do |key, value|
        @results[key] = @diesets[key].roll
      end
    end

    def to_s
      output = ""
      @results.each do |key, value|
        output << "#{key.to_s} = #{value.to_s}\n"
      end
      output
    end

  end
end
