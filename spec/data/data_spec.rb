require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Rats::Data do
  
  it "initializes" do
    data = Rats::Data.new
    data.is_a?(Rats::Data).should be_true
  end
  
  describe "attributes" do
    
    before(:each) do
      @data = Rats::Data.new
    end
    
    describe "writing and reading" do
      
      it "writes string" do
        @data.value = "1"
        @data.value.should == "1"
      end
      
      it "writes integer" do
        @data.value = 1
        @data.value.should == 1
      end
      
      it "writes string using alternate" do
        @data.v = "1"
        @data.v.should == "1"
        @data.value.should == "1"
      end
      
      it "writes integer using alternate" do
        @data.v = 1
        @data.v.should == 1
        @data.value.should == 1
      end
      
    end
    
  end
  
  describe "validation" do
    
    it "stubs valid? with true" do
      data = Rats::Data.new
      data.valid?.should be_true
    end
    
  end
  
  describe "methods" do
    
    it "pads the value" do
      data = Rats::Data.new(1)
      data.to_p.should == "1"
      
      Rats::Data.should_receive(:padding_width).twice.and_return(3)
      data.to_p.should == "  1"
      
      Rats::Data.should_receive(:padding_value).and_return("0")
      data.to_p.should == "001"
    end
    
    it "converts to string" do
      data = Rats::Data.new(1)
      data.to_s.should == "1"
    end
    
  end
  
  describe "traversing" do
    
    before(:each) do
      @data = Rats::Data.new
    end
    
    it "stubs left" do
      lambda { @data.left }.should raise_error(NotImplementedError)
    end
    
    it "stubs west" do
      lambda { @data.west }.should raise_error(NotImplementedError)
    end
    
    it "stubs right" do
      lambda { @data.right }.should raise_error(NotImplementedError)
    end
    
    it "stubs east" do
      lambda { @data.east }.should raise_error(NotImplementedError)
    end
    
    it "stubs up" do
      lambda { @data.up }.should raise_error(NotImplementedError)
    end
    
    it "stubs north" do
      lambda { @data.north }.should raise_error(NotImplementedError)
    end
    
    it "stubs down" do
      lambda { @data.down }.should raise_error(NotImplementedError)
    end
    
    it "stubs south" do
      lambda { @data.south }.should raise_error(NotImplementedError)
    end
    
  end
  
end