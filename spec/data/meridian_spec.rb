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
  
  describe "read/write" do
    
    it "returns a padded value" do
      data = Rats::Meridian.new('4')
      data.to_p.should == '4'
    end
    
    it "returns the integer" do
      data = Rats::Meridian.new('4')
      data.v.should == 4
    end
    
    it "returns a string" do
      data = Rats::Meridian.new('4')
      data.to_s.should == 'W4'
    end
    
    it "writes just the integer" do
      data = Rats::Meridian.new('W4')
      data.v.should == 4
    end
    
    describe "transforming" do
      
      it "accepts integers" do
        Rats::Meridian.transform(4).should == 4
      end
      
      it "accepts strings" do
        Rats::Meridian.transform('4').should == 4
      end
      
      it "accepts string prepended W" do
        Rats::Meridian.transform('W4').should == 4
      end
      
      it "accepts string prepended w" do
        Rats::Meridian.transform('w4').should == 4
      end
      
      it "doesn't accept other data" do
        Rats::Meridian.transform('E4').should be_nil
      end
      
    end
    
  end
  
end