require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Rats::Quarter do
  
  it "initializes" do
    data = Rats::Quarter.new
    data.is_a?(Rats::Quarter).should be_true
  end
  
  describe "boundaries" do
    
    it "allows valid data" do
      data = Rats::Quarter.new("NE")
      data.valid?.should be_true
    end
    
    it "doesn't allow bad data" do
      data = Rats::Quarter.new
      lambda { data.value = "bad" }.should raise_error(ArgumentError)
    end
    
  end
  
end