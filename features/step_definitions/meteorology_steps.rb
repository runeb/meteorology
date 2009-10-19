Given /^I have a geocoded Ruby class$/ do
  class SomeObj
    def latitude
      59.9
    end
    
    def longitude
      10.75
    end
  end
  
  FakeWeb.register_uri(:get, 
          Meteorology::Providers::Yr::URL % [59.9, 10.75],
          :body => File.read($fixture_dir + '/yr.no/locationforecast-1.6.xml'))
end

Given /^I include Meteorology in the objects class$/ do
  SomeObj.send(:include, Meteorology)
end

When /^the time is "([^\"]*)"$/ do |time|
  Time.stub!(:now).and_return(Time.parse(time))
end

When /^I ask for its current temperature$/ do
  @current_object       = SomeObj.new
  @all_weather          = @current_object.weather       # WeatherCollection
  @all_weather.should_not be_nil
  @current_weather      = @all_weather.current          # Weather obj
  @current_weather.should_not be_nil
  @current_temperature  = @current_weather.temperature  # String
  @current_temperature.should_not be_nil
  #@current_temperature = @current_object.weather.current.temperature
end

Then /^I should see "([^\"]*)"$/ do |degrees|
  @current_temperature.to_s.should == degrees
end
