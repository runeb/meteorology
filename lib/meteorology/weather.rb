module Meteorology
  class Weather
    attr_accessor :time, :temperature
    
    def initialize(time)
      @time = time.is_a?(String) ? Time.parse(time) : time
    end

  end
end