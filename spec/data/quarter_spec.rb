require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Rats::Quarter do
  
  it "initializes" do
    data = Rats::Quarter.new
    data.is_a?(Rats::Quarter).should be_true
  end
  
  it "returns the full_name" do
    data = Rats::Quarter.new('NE')
    data.fullname.should == "the Northeast Quarter"
  end
  
  describe "boundaries" do
    
    it "knows valid data" do
      data = Rats::Quarter.new('NE')
      data.valid?.should be_true
      data.error.should be_nil
    end
    
    it "knows invalid data" do
      data = Rats::Quarter.new('bad')
      data.valid?.should be_false
      data.error.should == "not allowed"
    end
    
  end
  
end