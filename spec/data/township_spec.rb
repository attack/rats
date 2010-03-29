require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Rats::Township do
  
  it "initializes" do
    data = Rats::Township.new
    data.is_a?(Rats::Township).should be_true
  end
  
  describe "boundaries" do
    
    it "allows valid data" do
      data = Rats::Township.new(6)
      data.valid?.should be_true
    end
    
    it "doesn't allow bad data" do
      data = Rats::Township.new
      lambda { data.value = 130 }.should raise_error(ArgumentError)
    end
    
  end
  
end