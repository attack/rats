require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Rats::Township do
  
  it "initializes" do
    data = Rats::Township.new
    data.is_a?(Rats::Township).should be_true
  end
  
  describe "boundaries" do
    
    it "knows valid data" do
      data = Rats::Township.new(6)
      data.valid?.should be_true
      data.error.should be_nil
    end
    
    it "knows invalid data" do
      data = Rats::Township.new(130)
      data.valid?.should be_false
      data.error.should == "not allowed"
    end
    
  end
  
  describe "read/write" do
    
    it "returns a padded value" do
      data = Rats::Township.new('4')
      data.to_p.should == '004'
    end
    
    it "returns the integer" do
      data = Rats::Township.new('4')
      data.v.should == 4
    end
    
    it "returns a string" do
      data = Rats::Township.new('4')
      data.to_s.should == '4'
    end
    
    it "writes the fullname" do
      data = Rats::Township.new('4')
      data.fullname.should == 'Township 4'
    end
    
    describe "transforming" do
      
      it "accepts integers" do
        Rats::Township.transform(4).should == 4
      end
      
      it "accepts strings" do
        Rats::Township.transform('4').should == 4
      end
      
      it "doesn't accept other data" do
        Rats::Township.transform('E4').should be_nil
      end
      
    end
    
  end
  
end