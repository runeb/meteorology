module Meteorology
  module Providers
    class Yr

      URL = "http://api.yr.no/weatherapi/locationforecast/1.6/?lat=%s;lon=%s"

      def load(lat, lng)
        parser = LibXML::XML::SaxParser.string(Net::HTTP.get(URI.parse(URL % [lat, lng])))
        parser.callbacks = XmlParser.new
        parser.parse
        return parser.callbacks.forecasts
      end

      class XmlParser
        attr_accessor :forecasts

        ATTR_MAPPING = {
          'fog' => :percent,
          'pressure' => :value,
          'highClouds' => :percent,
          'windDirection' => :name,
          'mediumClouds' => :percent,
          'windSpeed' => :mps,
          'cloudiness' => :percent,
          'lowClouds' => :percent,
          'humidity' => :value,
          'temperature' => :value,
          'symbol' => :number,
          'precipitation' => :value,
          'temperatureProbability' => :value,
          'windProbability' => :value,
          'symbolProbability' => :value
        }

        def initialize
          @forecasts = WeatherCollection.new
          @location = 0
        end
        
        def method_missing(*args)
          #dont care
        end

        def on_start_element(element, attributes)
          case element
          when 'time'
            if new_period?(attributes)
              key = Time.parse(attributes['from'])
              @current_period = @forecasts[key] = Meteorology::Weather.new(key)
            end
          when 'location'
            if @current_period
              @location += 1
            end
          else
            if @current_period && @location <= 2
              read_value(element, attributes)
            end
          end
        end

        def read_value(element, attributes)
          case element
          when 'temperature'
            @current_period.temperature = Meteorology::Temperature.new(attributes['unit'].to_sym, attributes['value'])
          else
            method = "#{element}="
            @current_period.send(method, attributes[ATTR_MAPPING[element].to_s]) if @current_period.respond_to?(method)            
          end
        end

        def on_end_element(element)
          if element == 'location' && @location == 2
            # Done with one period
            @location = 0
            @current_period = nil
          end
        end
        
        def new_period?(attributes)
          attributes['from'] == attributes['to']
        end

      end
      
      
    end
  end
end
