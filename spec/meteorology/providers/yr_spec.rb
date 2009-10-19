require 'spec_helper'

require 'fakeweb'

describe "Meteorology::Providers::Yr" do
  it "exists, d'uh" do
    lambda{Meteorology::Providers::Yr}.should_not raise_error(NameError)
  end
  
  context 'parsing' do
    before do
      @yr = Meteorology::Providers::Yr.new
      @lat = 59.9
      @lng = 10.75
      
      FakeWeb.allow_net_connect = false
      FakeWeb.register_uri(:get, 
              Meteorology::Providers::Yr::URL % [@lat, @lng],
              :body => File.read($fixture_dir + '/yr.no/locationforecast-1.6.xml'))

    end
    it 'parses yr xml files to a WeatherCollection' do
      wc = @yr.load(59.9, 10.75)
      wc.should be_instance_of(Meteorology::WeatherCollection)
      wc.size.should == 84
    end
  end
  
end
