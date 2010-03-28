require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Rats::Meridian do
  
  it "initializes" do
    data = Rats::Meridian.new
    data.is_a?(Rats::Meridian).should be_true
  end
  
end