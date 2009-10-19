require 'spec_helper'

describe "Meteorology::Weather" do
  it "exists, d'uh" do
    lambda{Meteorology::Weather}.should_not raise_error(NameError)
  end
  
  it 'accepts String or Time for time on #initialize' do
    Meteorology::Weather.new("2009-01-01").time.should be_instance_of(Time)
    Meteorology::Weather.new(Time.now).time.should be_instance_of(Time)
  end
  
  it 'reports #temperature' do
    w = Meteorology::Weather.new(Time.now.to_s)
    w.should respond_to(:temperature)
  end
end
