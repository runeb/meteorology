require 'spec_helper'

describe "Meteorology::Temperature" do
  it "exists, d'uh" do
    lambda{Meteorology::Temperature}.should_not raise_error(NameError)
  end
  
  it 'is instantiated with :farenheit or :celcuis and the degree' do
    lambda {temp = Meteorology::Temperature.new(:celcius, 10)}.should_not raise_error(ArgumentError)
    lambda {temp = Meteorology::Temperature.new(:farenheit, 100)}.should_not raise_error(ArgumentError)

    lambda {temp = Meteorology::Temperature.new(:foo, 100)}.should raise_error(ArgumentError)
    lambda {temp = Meteorology::Temperature.new(10)}.should raise_error(ArgumentError)
  end
  
  it 'pretty prints' do
    Meteorology::Temperature.new(:celcius, 10).to_s.should == "10 C"
    Meteorology::Temperature.new(:farenheit, 100).to_s.should == "100 F"
  end
  
end
