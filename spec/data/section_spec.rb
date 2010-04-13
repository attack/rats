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
  
  describe "read/write" do
    
    it "returns a padded value" do
      data = Rats::Section.new('4')
      data.to_p.should == '04'
    end
    
    it "returns the integer" do
      data = Rats::Section.new('4')
      data.v.should == 4
    end
    
    it "returns a string" do
      data = Rats::Section.new('4')
      data.to_s.should == '4'
    end
    
    describe "transforming" do
      
      it "accepts integers" do
        Rats::Section.transform(4).should == 4
      end
      
      it "accepts strings" do
        Rats::Section.transform('4').should == 4
      end
      
      it "doesn't accept other data" do
        Rats::Section.transform('E4').should be_nil
      end
      
    end
    
  end
  
end