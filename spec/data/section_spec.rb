require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Rats::Section do
  
  it "initializes" do
    data = Rats::Section.new
    data.is_a?(Rats::Section).should be_true
  end
  
  describe "boundaries" do
    
    it "allows valid data" do
      data = Rats::Section.new(6)
      data.valid?.should be_true
    end
    
    it "doesn't allow bad data" do
      data = Rats::Section.new
      lambda { data.value = 37 }.should raise_error(ArgumentError)
    end
    
  end
  
end