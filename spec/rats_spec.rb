require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Rats" do
  
  it "initializes the class" do
    land = Rats.new
    land.is_a?(Rats::Base).should be_true
  end
  
  describe "attributes" do
    
    before(:each) do
      @land = Rats.new
    end
    
    describe "writing and reading" do
      
      it "writes quarter" do
        @land.quarter = "NE"
        @land.quarter.should == "NE"
      end
      
      it "writes section" do
        @land.section = 1
        @land.section.should == 1
      end
      
      it "writes township" do
        @land.township = 1
        @land.township.should == 1
      end
      
      it "writes range" do
        @land.range = 1
        @land.range.should == 1
      end
      
      it "writes meridian" do
        @land.meridian = 4
        @land.meridian.should == 4
      end
      
    end
    
  end
  
  describe "parsing locations" do
    
    it "understands NE 1-2-3 W4" do
      land = Rats.new("NE 1-2-3 W4")
      land.quarter.should == "NE"
      land.section.should == 1
      land.township.should == 2
      land.range.should == 3
      land.meridian.should == 4
    end
    
    it "understands NE 1-1-1-4" do
      land = Rats.new("NE 1-2-3-4")
      land.quarter.should == "NE"
      land.section.should == 1
      land.township.should == 2
      land.range.should == 3
      land.meridian.should == 4
    end
    
    it "understands NE 1 2 3 4" do
      land = Rats.new("NE 1 2 3 4")
      land.quarter.should == "NE"
      land.section.should == 1
      land.township.should == 2
      land.range.should == 3
      land.meridian.should == 4
    end
    
    it "understands 40300201NE" do
      land = Rats.new("40300201NE")
      land.quarter.should == "NE"
      land.section.should == 1
      land.township.should == 2
      land.range.should == 3
      land.meridian.should == 4
    end
    
    it "understands 1-2-3 W4" do
      land = Rats.new("1-2-3 W4")
      land.quarter.should be_nil
      land.section.should == 1
      land.township.should == 2
      land.range.should == 3
      land.meridian.should == 4
    end
    
    it "understands 2-3 W4" do
      land = Rats.new("2-3 W4")
      land.quarter.should be_nil
      land.section.should be_nil
      land.township.should == 2
      land.range.should == 3
      land.meridian.should == 4
    end
    
    it "understands 3 W4" do
      land = Rats.new("3 W4")
      land.quarter.should be_nil
      land.section.should be_nil
      land.township.should be_nil
      land.range.should == 3
      land.meridian.should == 4
    end
    
    it "understands W4" do
      land = Rats.new("W4")
      land.quarter.should be_nil
      land.section.should be_nil
      land.township.should be_nil
      land.range.should be_nil
      land.meridian.should == 4
    end
    
    it "understands individual values" do
      land = Rats.new(4, 3, 2, 1, "NE")
      land.quarter.should == "NE"
      land.section.should == 1
      land.township.should == 2
      land.range.should == 3
      land.meridian.should == 4
    end
    
    it "understands SE 1-119-24 W4" do
      land = Rats.new("SE 1-119-24 W4")
      land.quarter.should == "SE"
      land.section.should == 1
      land.township.should == 119
      land.range.should == 24
      land.meridian.should == 4
    end
    
    describe "alternate method" do
    
      it "using location and a string" do
        land = Rats.new
        land.location = "NE 1-2-3 W4"
        land.quarter.should == "NE"
        land.section.should == 1
        land.township.should == 2
        land.range.should == 3
        land.meridian.should == 4
      end

      it "using location and individual values" do
        land = Rats.new
        land.location = [4, 3, 2, 1, "NE"]
        land.quarter.should == "NE"
        land.section.should == 1
        land.township.should == 2
        land.range.should == 3
        land.meridian.should == 4
      end
      
    end
    
  end
  
  describe "validation (does it exist)" do
    
    # each individual field has already been tested to know what is a valid field
    # here, I am testing the location as a whole, as a location can be valid
    # in respect to its individual components, but not as a whole
    
    it "knows a valid and existing location" do
      land = Rats.new("SE 1-2-3 W4")
      land.location.should == "SE 1-2-3 W4"
      land.exists?.should be_true
    end
    
    it "knows an non-existing section (in a valid township)" do
      land = Rats.new("SE 2-119-24 W4")
      land.exists?.should be_false
      
      # but it neightbour does
      land = Rats.new("SE 1-119-24 W4")
      land.exists?.should be_true
    end
    
    it "knows an non-existing township (in a valid range)" do
      land = Rats.new("SE 1-19-30 W4")
      land.exists?.should be_false
    end
    
    it "knows an non-existing range (in a valid township)" do
      land = Rats.new("SE 1-20-30 W4")
      land.exists?.should be_false
    end
    
  end
  
  describe "boundaries" do
                    
    it "knows when a township is North of Alberta" do
      land = Rats.new("SE 1-127-1 W4")
      land.valid?.should be_false
      land.errors.size.should == 1
      land.errors.has_key?(:township).should be_true
      land.errors[:township].first.should == 'not allowed'
    end
    
    it "knows when a township is East of Alberta" do
      land = Rats.new("SE 1-1-1 W3")
      land.valid?.should be_false
      land.errors.size.should == 1
      land.errors.has_key?(:meridian).should be_true
      land.errors[:meridian].first.should == 'not allowed'
    end
    
    it "knows when a township is West of Alberta" do
      land = Rats.new("SE 1-1-1 W7")
      land.valid?.should be_false
      land.errors.size.should == 1
      land.errors.has_key?(:meridian).should be_true
      land.errors[:meridian].first.should == 'not allowed'
    end
    
    it "knows when a township has been squeezed out" do
      land = Rats.new("SE 1-126-25 W4")
      land.valid?.should be_false
      land.errors.size.should == 1
      land.errors.has_key?(:land).should be_true
      land.errors[:land].first.should == 'does not exist'
    end
    
    it "knows when a section has been squeezed out" do
      land = Rats.new("SE 6-119-24 W4")
      land.valid?.should be_false
      land.errors.size.should == 1
      land.errors.has_key?(:land).should be_true
      land.errors[:land].first.should == 'does not exist'
    end
    
    # it "knows when a quarter has been squeezed out" do
    # end
    
  end
  
  describe "formatting" do
    
    describe ":default" do
    
      it "returns NE 1-2-3 W4" do
        land = Rats.new("NE 1-2-3 W4")
        land.location.should == "NE 1-2-3 W4"
      end
    
      it "returns 1-2-3 W4" do
        land = Rats.new("1-2-3 W4")
        land.location.should == "1-2-3 W4"
      end
    
      it "returns 2-3 W4" do
        land = Rats.new("2-3 W4")
        land.location.should == "2-3 W4"
      end
      
    end
    
    describe ":short" do
    
      it "returns NE01002034" do
        land = Rats.new("NE 1-2-3 W4")
        land.location(:short).should == "NE01002034"
      end
      
      it "returns 01001014" do
        land = Rats.new("1-2-3 W4")
        land.location(:short).should == "01002034"
      end

      it "returns 001014" do
        land = Rats.new("2-3 W4")
        land.location(:short).should == "002034"
      end

    end
    
    describe ":long" do
          
      it "returns the long version with Quarter" do
        land = Rats.new("NE 1-2-3 W4")
        land.location(:long).should == "the Northeast Quarter of Section 1, Township 2, Range 3, West of the Fourth Meridian"
      end
      
      it "returns the long version with Section" do
        land = Rats.new("1-2-3 W4")
        land.location(:long).should == "Section 1, Township 2, Range 3, West of the Fourth Meridian"
      end
      
      it "returns the long version with Township" do
        land = Rats.new("2-3 W4")
        land.location(:long).should == "Township 2, Range 3, West of the Fourth Meridian"
      end
      
    end
    
  end
  
  describe "scope" do
    
    it "knows quarter" do
      land = Rats.new("NE 1-2-3 W4")
      land.scope.should == :quarter
    end
    
    it "knows section" do
      land = Rats.new("1-2-3 W4")
      land.scope.should == :section
    end
    
    it "knows township" do
      land = Rats.new("2-3 W4")
      land.scope.should == :township
    end
    
    it "anything else is unknown" do
      land = Rats.new("3 W4")
      land.scope.should == :unknown
    end
    
  end
  
  describe "methods" do
    
    describe "validity" do
      
      it "knows when it is valid" do
        land = Rats.new("NE 1-2-3 W4")
        land.valid?.should be_true
      end
      
      it "knows when it isn't valid"do
        land = Rats.new("3 W4")
        land.valid?.should be_false
      end
      
    end
    
    it "responds_to :to_s" do
      land = Rats.new("NE 1-2-3 W4")
      land.to_s.should == land.location
    end
    
    it "responds_to :to_a" do
      land = Rats.new("NE 1-2-3 W4")
      land.to_a.should == ['NE', 1, 2, 3, 4]
      
      land = Rats.new("1-2-3 W4")
      land.to_a.should == [1, 2, 3, 4]
    end
                    
  end
  
end
