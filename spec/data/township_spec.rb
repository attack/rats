require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Rats::Township do
  
  it "initializes" do
    data = Rats::Township.new
    data.is_a?(Rats::Township).should be_true
  end
  
end