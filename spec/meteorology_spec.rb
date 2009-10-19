require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Meteorology" do
  it "exists, d'uh" do
    lambda { Meteorology }.should_not raise_error(NameError)
  end
end
