module Meteorology
  class WeatherCollection < Hash
    def current
      self.send("[]", current_time_key)
    end
    
    private
    def current_time_key
      Time.at((Time.now.to_f / 3600).round * 3600)
    end
  end
end
