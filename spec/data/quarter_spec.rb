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
  
  describe "traversing" do
    
    describe "correctly" do
      
      it "moves up" do
        data = Rats::Quarter.new("SE")
        data.up.v.should == "NE"
      end
      
      it "moves right" do
        data = Rats::Quarter.new("NW")
        data.right.v.should == "NE"
      end
      
      it "moves down" do
        data = Rats::Quarter.new("NW")
        data.down.v.should == "SW"
      end
      
      it "moves left" do
        data = Rats::Quarter.new("NE")
        data.left.v.should == "NW"
      end
      
    end
    
    describe "out of bounds" do
      
      it "moves up" do
        data = Rats::Quarter.new("NE")
        lambda { data.up }.should raise_error(Rats::OutOfBounds)
      end
      
      it "moves right" do
        data = Rats::Quarter.new("NE")
        lambda { data.right }.should raise_error(Rats::OutOfBounds)
      end
      
      it "moves down" do
        data = Rats::Quarter.new("SE")
        lambda { data.down }.should raise_error(Rats::OutOfBounds)
      end
      
      it "moves left" do
        data = Rats::Quarter.new("NW")
        lambda { data.left }.should raise_error(Rats::OutOfBounds)
      end
      
    end
    
  end
  
end