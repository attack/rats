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

    it "responds to error" do
      data = Rats::Data.new
      data.respond_to?('error').should be_true
    end

  end

  describe "methods" do

    it "pads the value" do
      data = Rats::Data.new(1)
      data.to_p.should == "1"

      #Rats::Data.should_receive(:padding_width).twice.and_return(3)
      Rats::Data.expects(:padding_width).twice.returns(3)
      data.to_p.should == "  1"

      #Rats::Data.should_receive(:padding_value).and_return("0")
      Rats::Data.expects(:padding_value).returns("0")
      data.to_p.should == "001"
    end

    it "converts to string" do
      data = Rats::Data.new(1)
      data.to_s.should == "1"
    end

    it "resets a value" do
      data = Rats::Data.new(1)
      data.v.should == 1
      data.nil!
      data.v.should be_nil
    end

  end

  describe "errors" do

    it "responds to raise_errors!" do
      data = Rats::Data.new
      data.respond_to?('raise_errors!').should be_true
    end

    it "responds to raise_errors?" do
      data = Rats::Data.new
      data.respond_to?('raise_errors?').should be_true
    end

    it "doesn't initially raise errors" do
      data = Rats::Data.new
      data.raise_errors?.should be_false
    end

    it "will raise errors if set" do
      data = Rats::Data.new(nil, true)
      data.raise_errors?.should be_true
    end

  end

end
