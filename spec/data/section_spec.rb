require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Rats::Section do
  
  it "initializes" do
    data = Rats::Section.new
    data.is_a?(Rats::Section).should be_true
  end
  
end