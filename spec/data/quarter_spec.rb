require_relative '../spec_helper'

describe Rats::Quarter do
  it "initializes" do
    data = Rats::Quarter.new
    data.is_a?(Rats::Quarter).should be_true
  end

  it "returns the full_name" do
    data = Rats::Quarter.new('NE')
    data.fullname.should == "the Northeast Quarter"
  end

  it "detects half" do
    Rats::Quarter.half?('NE').should be_false
    Rats::Quarter.half?('N').should be_true
    Rats::Quarter.half?('North').should be_true
  end

  it "transform input" do
    Rats::Quarter.transform('ne').should == 'NE'
    Rats::Quarter.transform('north').should == 'N'
    Rats::Quarter.transform('n').should == 'N'
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
