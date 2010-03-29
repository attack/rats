require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Rats::Range do
  
  it "initializes" do
    data = Rats::Range.new
    data.is_a?(Rats::Range).should be_true
  end
  
  describe "boundaries" do
    
    it "allows valid data" do
      data = Rats::Range.new(6)
      data.valid?.should be_true
    end
    
    it "doesn't allow bad data" do
      data = Rats::Range.new
      lambda { data.value = 31 }.should raise_error(ArgumentError)
    end
    
  end
  
end