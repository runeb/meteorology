require 'spec_helper'

describe 'Meteorology::WeatherCollection' do
  it "exists, d'uh" do
    lambda{Meteorology::WeatherCollection}.should_not raise_error(NameError)
  end
  
  before(:all) do
    @wc = Meteorology::WeatherCollection.new
    24.times do |i|
      time = Time.utc(2009, 10, 20, i, 0, 0)
      @wc[time] = Meteorology::Weather.new(time)
    end
  end
  
  it 'approximates to closest hour' do
    Time.stub!(:now).and_return(Time.utc(2009, 4, 29, 2, 27, 0))
    @wc.send(:current_time_key).should == Time.utc(2009, 4, 29, 2, 0, 0)
    
    Time.stub!(:now).and_return(Time.utc(2009, 4, 29, 2, 31, 0))
    @wc.send(:current_time_key).should == Time.utc(2009, 4, 29, 3, 0, 0)

    Time.stub!(:now).and_return(Time.utc(2009, 4, 29, 23, 45, 0))
    @wc.send(:current_time_key).should == Time.utc(2009, 4, 30, 0, 0, 0)
    
    Time.stub!(:now).and_return(Time.utc(2009, 12, 31, 23, 45, 0))
    @wc.send(:current_time_key).should == Time.utc(2010, 1, 1, 0, 0, 0)
    
  end
  
  it 'provides the #current weather on closest hour' do
    @wc.should respond_to(:current)
    
    time_now              = Time.utc(2009, 10, 20, 12, 27, 0)
    Time.stub!(:now).and_return(time_now)
    
    current = @wc.current
    current.should be_instance_of(Meteorology::Weather)
    current.time.should  == Time.utc(2009, 10, 20, 12, 00, 0)
    
  end
end
