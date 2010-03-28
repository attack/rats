require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Rats::Range do
  
  it "initializes" do
    data = Rats::Range.new
    data.is_a?(Rats::Range).should be_true
  end
  
end