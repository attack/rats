require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Rats::Meridian do
  
  it "initializes" do
    data = Rats::Meridian.new
    data.is_a?(Rats::Meridian).should be_true
  end
  
  describe "boundaries" do
    
    it "allows valid data" do
      data = Rats::Meridian.new(6)
      data.valid?.should be_true
    end
    
    it "doesn't allow bad data" do
      data = Rats::Meridian.new
      lambda { data.value = 3 }.should raise_error(ArgumentError)
    end
    
  end
  
end