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
        @land.meridian.should == "W4"
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
      land.meridian.should == "W4"
    end
    
    it "understands NE 1-1-1-4" do
      land = Rats.new("NE 1-2-3-4")
      land.quarter.should == "NE"
      land.section.should == 1
      land.township.should == 2
      land.range.should == 3
      land.meridian.should == "W4"
    end
    
    it "understands NE 1 2 3 4" do
      land = Rats.new("NE 1 2 3 4")
      land.quarter.should == "NE"
      land.section.should == 1
      land.township.should == 2
      land.range.should == 3
      land.meridian.should == "W4"
    end
    
    it "understands 40300201NE" do
      land = Rats.new("40300201NE")
      land.quarter.should == "NE"
      land.section.should == 1
      land.township.should == 2
      land.range.should == 3
      land.meridian.should == "W4"
    end
    
    # NOT SURE THIS IS USEFUL
    # it "understands NE01002034" do
    #   land = Rats.new("NE01002034")
    #   land.quarter.should == "NE"
    #   land.section.should == 1
    #   land.township.should == 2
    #   land.range.should == 3
    #   land.meridian.should == "W4"
    # end
    
    it "understands 1-2-3 W4" do
      land = Rats.new("1-2-3 W4")
      land.quarter.should be_nil
      land.section.should == 1
      land.township.should == 2
      land.range.should == 3
      land.meridian.should == "W4"
    end
    
    it "understands 2-3 W4" do
      land = Rats.new("2-3 W4")
      land.quarter.should be_nil
      land.section.should be_nil
      land.township.should == 2
      land.range.should == 3
      land.meridian.should == "W4"
    end
    
    it "understands 3 W4" do
      land = Rats.new("3 W4")
      land.quarter.should be_nil
      land.section.should be_nil
      land.township.should be_nil
      land.range.should == 3
      land.meridian.should == "W4"
    end
    
    it "understands W4" do
      land = Rats.new("W4")
      land.quarter.should be_nil
      land.section.should be_nil
      land.township.should be_nil
      land.range.should be_nil
      land.meridian.should == "W4"
    end
    
    it "understands individual values" do
      land = Rats.new("NE", 1, 2, 3, 4)
      land.quarter.should == "NE"
      land.section.should == 1
      land.township.should == 2
      land.range.should == 3
      land.meridian.should == "W4"
    end
    
    describe "alternate method" do
    
      it "using location and a string" do
        land = Rats.new
        land.location = "NE 1-2-3 W4"
        land.quarter.should == "NE"
        land.section.should == 1
        land.township.should == 2
        land.range.should == 3
        land.meridian.should == "W4"
      end

      it "using location and individual values" do
        land = Rats.new
        land.location = ["NE", 1, 2, 3, 4]
        land.quarter.should == "NE"
        land.section.should == 1
        land.township.should == 2
        land.range.should == 3
        land.meridian.should == "W4"
      end
      
    end
    
  end
  
  describe "boundaries" do
    
    it "knows a valid township (regardless of range)"
    
    it "knows a valid range based on township"
    
    it "knows a valid merdian"
    
    it "knows when a township (at a valid range,township,meridian) doesn't exist"
    
    it "knows when a township is North of Alberta"
    
    it "knows when a township is East of Alberta"
    
    it "knows when a township is West of Alberta"
    
  end
  
  describe "taversing" do
    
    describe "from quarter to quarter" do
    
      describe "within a township" do
    
        describe "within a section" do
      
          it "knows what is up (north)"
      
          it "knows what is down (south)"
      
          it "knows what is left (west)"
      
          it "knows what is right (east)"
      
        end
    
        describe "outside a section" do
        
          it "knows what is up (north)"

          it "knows what is down (south)"

          it "knows what is left (west)"

          it "knows what is right (east)"
        
        end
        
      end
      
      describe "outside a township (which inplies outside a section)" do

        # townships do not line up North to South, so you can't know
        # what township/section/quarter is above another when you
        # leave a township

        it "knows it can't go up (north)"

        it "knows it can't go down (south)"

        it "knows what is left (west)"

        it "knows what is right (east)"

      end
      
    end
    
    describe "from section to section" do
    
      describe "within a township" do
      
        it "knows what is up (north)"
      
        it "knows what is down (south)"
      
        it "knows what is left (west)"
      
        it "knows what is right (east)"
      
      end
    
      describe "outside a township" do
        
        # townships do not line up North to South, so you can't know
        # what township/section/quarter is above another when you
        # leave a township
      
        it "knows it can't go up (north)"

        it "knows it can't go down (south)"

        it "knows what is left (west)"

        it "knows what is right (east)"
        
      end
      
    end
    
    describe "from township to township" do
      
      describe "within a meridian" do
      
        it "goes East"
        
        it "goes West"
        
        it "doesn't go North"
        
        it "doesn't go South"
      
      end
      
    end
    
    describe "from quarter to section" do
      
      it "TODO knows this"
      
    end
    
    describe "from quarter to township" do
      
      it "TODO knows this"
      
    end
    
    describe "from sectino to township" do
      
      it "TODO knows this"
      
    end
    
  end
  
  describe "formatting" do
    
    describe ":long" do
    
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
    
    it "responds_to :to_s"
    
    it "responds_to :to_a"
        
    it "copies the class"
            
  end
  
end
