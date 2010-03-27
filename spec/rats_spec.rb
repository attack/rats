require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Rats" do
  
  it "initializes the class" do
    land = LegalLandDescription.new
    land.is_a?(Rats::LegalLandDescription).should be_true
  end
  
  describe "attributes" do
    
    before(:each) do
      @land = LegalLandDescription.new
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
        @land.meridian = 1
        @land.meridian.should == "W1"
      end
      
    end
    
  end
  
  describe "parsing locations" do
    
    it "understands NE 1-2-3 W4" do
      land = LegalLandDescription.new("NE 1-2-3 W4")
      land.quarter.should == "NE"
      land.section.should == 1
      land.township.should == 2
      land.range.should == 3
      land.meridian.should == "W4"
    end
    
    it "understands NE 1-1-1-4" do
      land = LegalLandDescription.new("NE 1-2-3-4")
      land.quarter.should == "NE"
      land.section.should == 1
      land.township.should == 2
      land.range.should == 3
      land.meridian.should == "W4"
    end
    
    it "understands NE 1 2 3 4" do
      land = LegalLandDescription.new("NE 1 2 3 4")
      land.quarter.should == "NE"
      land.section.should == 1
      land.township.should == 2
      land.range.should == 3
      land.meridian.should == "W4"
    end
    
    it "understands 40300201NE" do
      land = LegalLandDescription.new("40300201NE")
      land.quarter.should == "NE"
      land.section.should == 1
      land.township.should == 2
      land.range.should == 3
      land.meridian.should == "W4"
    end
    
    # NOT SURE THIS IS USEFUL
    # it "understands NE01002034" do
    #   land = LegalLandDescription.new("NE01002034")
    #   land.quarter.should == "NE"
    #   land.section.should == 1
    #   land.township.should == 2
    #   land.range.should == 3
    #   land.meridian.should == "W4"
    # end
    
    it "understands 1-2-3 W4" do
      land = LegalLandDescription.new("1-2-3 W4")
      land.quarter.should be_nil
      land.section.should == 1
      land.township.should == 2
      land.range.should == 3
      land.meridian.should == "W4"
    end
    
    it "understands 2-3 W4" do
      land = LegalLandDescription.new("2-3 W4")
      land.quarter.should be_nil
      land.section.should be_nil
      land.township.should == 2
      land.range.should == 3
      land.meridian.should == "W4"
    end
    
    it "understands 3 W4" do
      land = LegalLandDescription.new("3 W4")
      land.quarter.should be_nil
      land.section.should be_nil
      land.township.should be_nil
      land.range.should == 3
      land.meridian.should == "W4"
    end
    
    it "understands W4" do
      land = LegalLandDescription.new("W4")
      land.quarter.should be_nil
      land.section.should be_nil
      land.township.should be_nil
      land.range.should be_nil
      land.meridian.should == "W4"
    end
    
    it "understands individual values" do
      land = LegalLandDescription.new("NE", 1, 2, 3, 4)
      land.quarter.should == "NE"
      land.section.should == 1
      land.township.should == 2
      land.range.should == 3
      land.meridian.should == "W4"
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
    
      it "returns NE 1-1-1 W4"
    
      it "returns 1-1-1 W4"
    
      it "returns 1-1 W4"
      
    end
    
    describe ":short" do
    
      it "returns NE01001014"
      
      it "returns 01001014"

      it "returns 001014"

    end
    
  end
  
  describe "scope" do
    
    it "knows quarter"
    
    it "knows section"
    
    it "knows township"
    
  end
  
  describe "methods" do
    
    it "copies the class"
    
    it "knows when it is valid"
    
    it "parses using location as well as new"
    
  end
  
end
