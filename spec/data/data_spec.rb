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
  
  describe "methods" do
    
    it "pads the value" do
      data = Rats::Data.new(1)
      data.to_p(1).should == "1"
      data.to_p(3).should == "001"
    end
    
    it "converts to string" do
      data = Rats::Data.new(1)
      data.to_s.should == "1"
    end
    
  end
  
end