require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Rats::Quarter do
  
  it "initializes" do
    data = Rats::Quarter.new
    data.is_a?(Rats::Quarter).should be_true
  end
  
end