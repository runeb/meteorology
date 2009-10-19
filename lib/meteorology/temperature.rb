module Meteorology
  class Temperature
    def initialize(system, degrees)
      raise ArgumentError.new("Need :farenheit or :celcius") unless [:farenheit, :celcius].include? system
      
      @degrees = degrees
      @system = system
    end
    
    def to_s
      "#{@degrees} #{@system.to_s[0,1].upcase}"
    end
  end
end
